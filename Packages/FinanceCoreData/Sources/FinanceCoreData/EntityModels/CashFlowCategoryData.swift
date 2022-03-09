//
//  CashFlowCategoryData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public struct CashFlowCategoryData {
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


// MARK: - Sample Data

extension CashFlowCategoryData {
    static let foodExpense = CashFlowCategoryData(name: "Food", icon: .carFill, color: .red, type: .expense)
    static let carExpense = CashFlowCategoryData(name: "Car", icon: .airplane, color: .gray, type: .expense)
    static let hobbyExpense = CashFlowCategoryData(name: "Hobby", icon: .fuelpumpFill, color: .blue, type: .expense)

    static let workIncome = CashFlowCategoryData(name: "Payment", icon: .bagFill, color: .pink, type: .income)
    static let workBonus = CashFlowCategoryData(name: "Work bonus", icon: .gameControllerFill, color: .yellow, type: .income)

    static let sampleExpenses: [CashFlowCategoryData] = [.foodExpense, .carExpense, .hobbyExpense]
    static let sampleIncomes: [CashFlowCategoryData] = [.workIncome, .workBonus]
}
