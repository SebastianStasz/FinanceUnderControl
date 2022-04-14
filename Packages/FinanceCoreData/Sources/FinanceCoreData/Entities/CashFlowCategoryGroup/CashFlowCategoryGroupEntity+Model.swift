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
        public let color: CashFlowCategoryColor
        public let categories: [CashFlowCategoryEntity]

        public init(name: String, type: CashFlowType, color: CashFlowCategoryColor, categories: [CashFlowCategoryEntity] = []) {
            self.name = name
            self.type = type
            self.color = color
            self.categories = categories.sorted(by: { $0.name < $1.name })
        }
    }
}

// MARK: - Sample Data

extension CashFlowCategoryGroupEntity.Model {
    static let foodExpense = CashFlowCategoryGroupEntity.Model(name: "Food", type: .expense, color: .blue)
    static let carExpense = CashFlowCategoryGroupEntity.Model(name: "Car", type: .expense, color: .brown)
    static let workIncome = CashFlowCategoryGroupEntity.Model(name: "Work", type: .income, color: .green)

    static func carExpense(withCategories categories: [CashFlowCategoryEntity]) -> CashFlowCategoryGroupEntity.Model {
        .init(name: "Car", type: .expense, color: .indigo, categories: categories)
    }

    static func foodExpense(withCategories categories: [CashFlowCategoryEntity]) -> CashFlowCategoryGroupEntity.Model {
        .init(name: "Food", type: .expense, color: .mint, categories: categories)
    }
}
