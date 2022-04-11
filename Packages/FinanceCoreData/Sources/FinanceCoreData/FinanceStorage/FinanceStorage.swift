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
        let groups = await CashFlowCategoryGroupEntity.getAll(from: controller)
        let categories = await CashFlowCategoryEntity.getAll(from: controller)
        let cashFlows = await CashFlowEntity.getAll(from: controller)
        return .init(groups: groups, categories: categories, cashFlows: cashFlows)
    }
}
