//
//  CashFlowEntity+FormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 03/04/2022.
//

import FinanceCoreData
import Foundation
import Shared

struct CashFlowFormModel: Equatable {
    var date = Date()
    var name: String?
    var value: Decimal?
    var currency: Currency? = .PLN
    var category: CashFlowCategory?
    var type: CashFlowType

    var model: CashFlow? {
        guard let name = name, let value = value, let category = category else { return nil }
        return CashFlow(id: UUID().uuidString, name: name, money: Money(value, currency: currency!), date: date, type: type, category: category)
    }
}
