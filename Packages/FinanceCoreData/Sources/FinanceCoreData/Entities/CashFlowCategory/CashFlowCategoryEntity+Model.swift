//
//  CashFlowCategoryEntity+Model.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public extension CashFlowCategoryEntity {

    struct Model {
        public let name: String
        public let icon: CashFlowCategoryIcon
        public let color: CashFlowCategoryColor
        public let type: CashFlowType

        public init(
            name: String,
            icon: CashFlowCategoryIcon,
            color: CashFlowCategoryColor,
            type: CashFlowType
        ) {
            self.name = name
            self.icon = icon
            self.color = color
            self.type = type
        }
    }
}

// MARK: - Sample Model

public extension CashFlowCategoryEntity.Model {
    static let foodExpense = CashFlowCategoryEntity.Model(name: "Food", icon: .carFill, color: .red, type: .expense)
    static let carExpense = CashFlowCategoryEntity.Model(name: "Car", icon: .airplane, color: .gray, type: .expense)
    static let hobbyExpense = CashFlowCategoryEntity.Model(name: "Hobby", icon: .fuelpumpFill, color: .blue, type: .expense)

    static let workIncome = CashFlowCategoryEntity.Model(name: "Payment", icon: .bagFill, color: .pink, type: .income)
    static let workBonus = CashFlowCategoryEntity.Model(name: "Work bonus", icon: .gameControllerFill, color: .yellow, type: .income)

    static let sampleExpenses: [CashFlowCategoryEntity.Model] = [.foodExpense, .carExpense, .hobbyExpense]
    static let sampleIncomes: [CashFlowCategoryEntity.Model] = [.workIncome, .workBonus]
}
