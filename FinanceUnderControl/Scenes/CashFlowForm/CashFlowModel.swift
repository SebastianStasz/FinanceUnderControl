//
//  CashFlowModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 12/01/2022.
//

import FinanceCoreData
import Foundation

struct CashFlowModel {
    var date = Date()
    var name: String?
    var value: Double?
    var currency: CurrencyEntity?
    var category: CashFlowCategoryEntity?
    var type: CashFlowType?

    var cashFlowData: CashFlowData? {
        guard let name = name,
              let value = value,
              let currency = currency,
              let category = category
        else { return nil }
        return CashFlowData(name: name, date: date, value: value, currency: currency, category: category)
    }
}
