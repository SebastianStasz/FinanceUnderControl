//
//  FinanceStorageModel.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 07/04/2022.
//

import CoreData
import Foundation
import SSUtils

enum FinanceStorageError: Error {
    case convertingJsonDataToString
    case convertingStringToJsonData
}

public struct FinanceStorageModel: Codable {
    public let groups: [CashFlowCategoryGroupEntity.DataModel]
    public let categories: [CashFlowCategoryEntity.DataModel]
    public let cashFlows: [CashFlowEntity.DataModel]
}

public extension FinanceStorageModel {

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

    static func generate(from controller: PersistenceController) async -> FinanceStorageModel {
        let groups = await CashFlowCategoryGroupEntity.getAll(from: controller)
        let categories = await CashFlowCategoryEntity.getAll(from: controller)
        let cashFlows = await CashFlowEntity.getAll(from: controller)
        return .init(groups: groups, categories: categories, cashFlows: cashFlows)
    }

    }
}
