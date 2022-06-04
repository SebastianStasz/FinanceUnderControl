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
    var description = ""
    var currency: Currency? = .PLN
    var category: CashFlowCategory?
    var type: CashFlowType

    var isValid: Bool {
        name.notNil && value.notNil && currency.notNil && category.notNil
    }

    func model(for formType: CashFlowFormType<CashFlow>) -> CashFlow? {
        guard let name = name, let value = value, let category = category else { return nil }
        switch formType {
        case let .new(type):
            return CashFlow(id: UUID().uuidString, name: name, money: .init(value, currency: currency ?? .PLN), date: date, type: type, category: category)
        case let .edit(cashFlow):
            return CashFlow(id: cashFlow.id, name: name, money: .init(value, currency: currency ?? .PLN), date: date, type: type, category: category)
        }
    }
}
