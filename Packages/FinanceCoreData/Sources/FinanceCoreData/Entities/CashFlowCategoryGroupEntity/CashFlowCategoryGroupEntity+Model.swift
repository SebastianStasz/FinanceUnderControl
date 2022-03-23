//
//  CashFlowCategoryGroupEntity+Model.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//

import Foundation

public extension CashFlowCategoryGroupEntity {

    struct Model {
        public let name: String
        public let type: CashFlowType

        public init(name: String, type: CashFlowType) {
            self.name = name
            self.type = type
        }
    }
}

// MARK: - Sample Data

extension CashFlowCategoryGroupEntity.Model {
    static let foodExpense = CashFlowCategoryGroupEntity.Model(name: "Food", type: .expense)
    static let carExpense = CashFlowCategoryGroupEntity.Model(name: "Car", type: .expense)
    static let workIncome = CashFlowCategoryGroupEntity.Model(name: "Work", type: .income)
}
