//
//  CashFlowEntity+FormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 03/04/2022.
//

import Foundation
import FinanceCoreData

extension CashFlowEntity {

    struct FormModel: CashFlowGroupingFormModel {
        typealias Ent = CashFlowEntity

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
}
