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
        public let type: CashFlowType
        public let group: CashFlowCategoryGroupEntity?

        public init(
            name: String,
            icon: CashFlowCategoryIcon,
            type: CashFlowType,
            group: CashFlowCategoryGroupEntity? = nil
        ) {
            self.name = name
            self.icon = icon
            self.type = type
            self.group = group
        }
    }
}

// MARK: - Sample Model

public extension CashFlowCategoryEntity.Model {
    static let foodExpense = CashFlowCategoryEntity.Model(name: "Food", icon: .carFill, type: .expense)
    static let carExpense = CashFlowCategoryEntity.Model(name: "Car", icon: .airplane, type: .expense)
    static let hobbyExpense = CashFlowCategoryEntity.Model(name: "Hobby", icon: .fuelpumpFill, type: .expense)

    static let workIncome = CashFlowCategoryEntity.Model(name: "Payment", icon: .bagFill, type: .income)
    static let workBonus = CashFlowCategoryEntity.Model(name: "Work bonus", icon: .gameControllerFill, type: .income)

    static let sampleExpenses: [CashFlowCategoryEntity.Model] = [.foodExpense, .carExpense, .hobbyExpense]
    static let sampleIncomes: [CashFlowCategoryEntity.Model] = [.workIncome, .workBonus]
}
