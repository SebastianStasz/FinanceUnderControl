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
    static let foodExpense = CashFlowCategoryData(name: "Food", type: .expenses)
    static let workExpense = CashFlowCategoryData(name: "Work", type: .expenses)
    static let workIncome = CashFlowCategoryData(name: "Work", type: .income)
}
