//
//  FinanceDataImporter.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 11/04/2022.
//

import Foundation
import SSUtils

public struct FinanceDataImporter {
    private let controller: PersistenceController
    private let groupsToCreate: [CashFlowCategoryGroupEntity.DataModel]
    private let categoriesToCreate: [CashFlowCategoryEntity.DataModel]
    private let cashFlowsToCreate: [CashFlowEntity.DataModel]

    public let importResult: Result

    public init(from controller: PersistenceController, financeData: FinanceData) async {
        self.controller = controller

        let existingGroups = await CashFlowCategoryGroupEntity.getAll(from: controller)
        let existingCategories = await CashFlowCategoryEntity.getAll(from: controller)
        let existingCashFlows = await CashFlowEntity.getAll(from: controller)

        let groupsToCreate = financeData.groups.filter { group in
            !existingGroups.contains(where: { group.name == $0.name && group.type == $0.type })
        }
        let categoriesToCreate = financeData.categories.filter { category in
            !existingCategories.contains(where: { category.name == $0.name && category.type == $0.type })
        }
        let cashFlowsToCreate = financeData.cashFlows.filter { cashFlow in
            !existingCashFlows.contains(where: { cashFlow.name == $0.name && cashFlow.date == $0.date })
        }
        let groupsResult = financeData.groups.map {
            ResultItem(name: $0.name, willBeCreated: groupsToCreate.contains($0))
        }
        let categoriesResult = financeData.categories.map {
            ResultItem(name: $0.name, willBeCreated: categoriesToCreate.contains($0))
        }
        let cashFlowsResult = financeData.cashFlows.map {
            ResultItem(name: $0.name, willBeCreated: cashFlowsToCreate.contains($0))
        }

        self.groupsToCreate = groupsToCreate
        self.categoriesToCreate = categoriesToCreate
        self.cashFlowsToCreate = cashFlowsToCreate
        self.importResult = Result(groups: groupsResult, categories: categoriesResult, cashFlows: cashFlowsResult)
    }

    public func create() async {
        try? controller.context.save()

        let groupsModel = groupsToCreate.map { group in
            group.model
        }
        let categoryModels = await categoriesToCreate.asyncMap {
            await $0.getModel(from: controller)
        }
        let cashFlowModels = await cashFlowsToCreate.asyncMap {
            await $0.getModel(from: controller)
        }

        for model in groupsModel {
            await CashFlowCategoryGroupEntity.create(in: controller, model: model)
        }
        for model in categoryModels {
            await CashFlowCategoryEntity.create(in: controller, model: model)
        }
        for model in cashFlowModels {
            await CashFlowEntity.create(in: controller, model: model)
        }

        try? controller.backgroundContext.save()
    }
}
