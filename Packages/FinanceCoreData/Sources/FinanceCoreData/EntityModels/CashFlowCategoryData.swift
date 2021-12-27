//
//  CashFlowCategoryData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public struct CashFlowCategoryData {
    public let name: String
    public let type: CashFlowCategoryType
}


// MARK: - Sample Data

extension CashFlowCategoryData {
    static let foodExpense = CashFlowCategoryData(name: "Food", type: .expense)
    static let carExpense = CashFlowCategoryData(name: "Car", type: .expense)
    static let hobbyExpense = CashFlowCategoryData(name: "Hobby", type: .expense)

    static let workIncome = CashFlowCategoryData(name: "Work", type: .income)
    static let parentsIncome = CashFlowCategoryData(name: "From parents", type: .income)

    static let sampleExpenses: [CashFlowCategoryData] = [.foodExpense, .carExpense, .hobbyExpense]
    static let sampleIncomes: [CashFlowCategoryData] = [.workIncome, .parentsIncome]
}
