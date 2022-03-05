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
    public let type: CashFlowCategoryType

    public init(name: String, icon: CashFlowCategoryIcon, type: CashFlowCategoryType) {
        self.name = name
        self.icon = icon
        self.type = type
    }
}


// MARK: - Sample Data

extension CashFlowCategoryData {
    static let foodExpense = CashFlowCategoryData(name: "Food", icon: .carFill, type: .expense)
    static let carExpense = CashFlowCategoryData(name: "Car", icon: .airplane, type: .expense)
    static let hobbyExpense = CashFlowCategoryData(name: "Hobby", icon: .fuelpumpFill, type: .expense)

    static let workPayment = CashFlowCategoryData(name: "Payment", icon: .bagFill, type: .income)
    static let workBonus = CashFlowCategoryData(name: "Work bonus", icon: .gameControllerFill, type: .income)

    static let sampleExpenses: [CashFlowCategoryData] = [.foodExpense, .carExpense, .hobbyExpense]
    static let sampleIncomes: [CashFlowCategoryData] = [.workPayment, .workBonus]
}
