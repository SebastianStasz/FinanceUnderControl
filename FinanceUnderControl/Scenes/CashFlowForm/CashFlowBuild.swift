//
//  CashFlowBuild.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 12/01/2022.
//

import FinanceCoreData
import Foundation

struct CashFlowBuild: Equatable {
    var date = Date()
    var name: String?
    var value: Double?
    var currency: CurrencyEntity?
    var category: CashFlowCategoryEntity?
    var type: CashFlowType?

    var model: CashFlowEntity.Model? {
        guard let name = name,
              let value = value,
              let currency = currency,
              let category = category
        else { return nil }
        return CashFlowEntity.Model(name: name, date: date, value: value, currency: currency, category: category)
    }
}
