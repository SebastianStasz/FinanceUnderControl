//
//  FinanceStorageModel.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import CoreData
import Foundation

public struct FinanceStorageModel: Encodable {
    public let groups: [CashFlowCategoryGroupEntity.DataModel]
    public let categories: [CashFlowCategoryEntity.DataModel]
    public let cashFlows: [CashFlowEntity.DataModel]
}

public extension FinanceStorageModel {
    static func generate(from context: NSManagedObjectContext) async -> FinanceStorageModel {
        let groups = await CashFlowCategoryGroupEntity.getAll(from: context)
        return .init(groups: groups, categories: [], cashFlows: [])
    }
}
