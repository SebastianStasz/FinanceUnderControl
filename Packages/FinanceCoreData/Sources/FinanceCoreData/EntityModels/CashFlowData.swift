//
//  CashFlowData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public struct CashFlowData {
    public let name: String
    public let date: Date
    public let value: Double
    public let currency: CurrencyEntity
    public let category: CashFlowCategoryEntity
}


// MARK: - Sample Data {

extension CashFlowData {
    static func sample1(currency: CurrencyEntity, category: CashFlowCategoryEntity) -> CashFlowData {
        CashFlowData(name: "Sample1", date: Date(), value: 10, currency: currency, category: category)
    }

//    static var sampleCashFlows: [CashFlowData] {
//        let expenseCategories = CashFlowCategoryData.sampleExpenses
//        let incomeCategories = CashFlowCategoryData.sampleIncomes
//
//        let incomes: [CashFlowData] = [
//            .init(name: "Salary 1", date: <#T##Date#>, value: 4500, category: <#T##CashFlowCategoryEntity#>)
//        ]
//        return []
//    }
}
