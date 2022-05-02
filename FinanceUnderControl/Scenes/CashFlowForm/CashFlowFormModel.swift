//
//  CashFlowEntity+FormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 03/04/2022.
//

import FinanceCoreData
import Foundation
import Shared

struct CashFlowFormModel {
    var date = Date()
    var name: String?
    var value: Decimal?
    var currency: Currency? = .PLN
    var categoryId: String?
    var type: CashFlowType?

    var model: CashFlow? {
        guard let name = name, let value = value, let categoryId = categoryId else { return nil }
        return CashFlow(name: name, money: Money(value, currency: currency!), date: date, categoryId: categoryId)
    }
}


extension CashFlowEntity {

    struct FormModel: CashFlowGroupingFormModel {
        typealias Ent = CashFlowEntity

        var date = Date()
        var name: String?
        var value: Decimal?
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
}
