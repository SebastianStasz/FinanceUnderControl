//
//  FinanceStorage.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import CoreData
import Foundation
import SSUtils

public struct FinanceStorage: Codable {
    public let groups: [CashFlowCategoryGroupEntity.DataModel]
    public let categories: [CashFlowCategoryEntity.DataModel]
    public let cashFlows: [CashFlowEntity.DataModel]
}

public extension FinanceStorage {

    func getImportResult(for controller: PersistenceController) async -> ImportResult {
        await Task {
            let existingGroups = await CashFlowCategoryGroupEntity.getAll(from: controller)
            let existingCategories = await CashFlowCategoryEntity.getAll(from: controller)
            let existingCashFlows = await CashFlowEntity.getAll(from: controller)

            let groupResultItems = groups.map { group in
                ImportResult.Item(name: group.name, alreadyExists: existingGroups.contains(where: { group.name == $0.name && group.type == $0.type }))
            }
            let categoryResultItems = categories.map { category in
                ImportResult.Item(name: category.name, alreadyExists: existingCategories.contains(where: { category.name == $0.name && category.type == $0.type }))
            }
            let cashFlowResultItems = cashFlows.map { cashFlow in
                ImportResult.Item(name: cashFlow.name, alreadyExists: existingCashFlows.contains(where: { cashFlow.name == $0.name && cashFlow.date == $0.date }))
            }
            return ImportResult(groups: groupResultItems, categories: categoryResultItems, cashFlows: cashFlowResultItems)
        }
        .value
    }

    func toJsonString() async throws -> String {
        try await Task {
            do {
                let data = try JSONEncoder().encode(self)
                guard let jsonString = String(data: data, encoding: .utf8) else {
                    throw FinanceStorageError.convertingJsonDataToString
                }
                return jsonString
            }
        }.value
    }

    static func generate(from controller: PersistenceController) async -> FinanceStorage {
        try? controller.context.save()
        let groups = await CashFlowCategoryGroupEntity.getAll(from: controller).map { $0.dataModel }
        let categories = await CashFlowCategoryEntity.getAll(from: controller).map { $0.dataModel }
        let cashFlows = await CashFlowEntity.getAll(from: controller).map { $0.dataModel }
        return .init(groups: groups, categories: categories, cashFlows: cashFlows)
    }

    func create(in controller: PersistenceController) async {
        try? controller.context.save()
        await createGroups(in: controller)
        await createCategories(in: controller)
        await createCashFlows(in: controller)
    }

    private func createGroups(in controller: PersistenceController) async {
        let existingGroups = await CashFlowCategoryGroupEntity.getAll(from: controller)

        let groupsToCreate = groups
            .filter { group in !existingGroups.contains(where: { group.name == $0.name && group.type == $0.type }) }
            .map { CashFlowCategoryGroupEntity.Model(name: $0.name, type: $0.type) }

        for group in groupsToCreate {
            await CashFlowCategoryGroupEntity.create(in: controller, model: group)
        }
    }

    private func createCategories(in controller: PersistenceController) async {
        let groups = await CashFlowCategoryGroupEntity.getAll(from: controller)
        let existingCategories = await CashFlowCategoryEntity.getAll(from: controller)

        let categoriesToCreate = categories
            .filter { category in !existingCategories.contains(where: { category.name == $0.name && category.type == $0.type }) }
            .map { cat in
                CashFlowCategoryEntity.Model(name: cat.name, icon: cat.icon, color: cat.color, type: cat.type, group: groups.first(where: { cat.groupName == $0.name }))
            }

        for category in categoriesToCreate {
            await CashFlowCategoryEntity.create(in: controller, model: category)
        }
    }

    private func createCashFlows(in controller: PersistenceController) async {
        let categories = await CashFlowCategoryEntity.getAll(from: controller)
        let existingCashFlows = await CashFlowEntity.getAll(from: controller)
        let currencies = await CurrencyEntity.getAll(from: controller)

        let cashFlowsToCreate = cashFlows
            .filter { cashFlow in !existingCashFlows.contains(where: { cashFlow.name == $0.name && cashFlow.date == $0.date }) }
            .map { cashFlow -> CashFlowEntity.Model in
                let currency = currencies.first(where: { cashFlow.currencyCode == $0.code })!
                let category = categories.first(where: { cashFlow.categoryName == $0.name && cashFlow.type == $0.type })!
                return CashFlowEntity.Model(name: cashFlow.name, date: cashFlow.date, value: cashFlow.value, currency: currency, category: category)
            }

        for cashFlow in cashFlowsToCreate {
            await CashFlowEntity.create(in: controller, model: cashFlow)
        }
    }
}
