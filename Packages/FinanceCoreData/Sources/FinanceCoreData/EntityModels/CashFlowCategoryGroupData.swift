//
//  CashFlowCategoryGroupData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//

import Foundation

public struct CashFlowCategoryGroupData {
    public let name: String
    public let type: CashFlowType

    public init(name: String, type: CashFlowType) {
        self.name = name
        self.type = type
    }
}


// MARK: - Sample Data

extension CashFlowCategoryGroupData {
    static let foodExpense = CashFlowCategoryGroupData(name: "Food", type: .expense)
    static let carExpense = CashFlowCategoryGroupData(name: "Car", type: .expense)
    static let workIncome = CashFlowCategoryGroupData(name: "Work", type: .income)
}
