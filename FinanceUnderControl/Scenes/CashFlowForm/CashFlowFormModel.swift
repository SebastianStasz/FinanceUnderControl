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

    var model: CashFlowDocument? {
        guard let name = name, let value = value, let categoryId = categoryId else { return nil }
        return CashFlowDocument(name: name, money: Money(value, currency: currency!), date: date, categoryId: categoryId)
    }
}

enum CashFlowForm {
    case new(for: CashFlowType)
    case edit

    var title: String {
        switch self {
        case .new(let type):
            return type == .income ? .cash_flow_add_income : .cash_flow_add_expense
        case .edit:
//            return type == .income ? .cash_flow_edit_income : .cash_flow_edit_expense
            return "Edit"
        }
    }

    var confirmButtonTitle: String {
        switch self {
        case .new:
            return .button_create
        case .edit:
            return .common_save
        }
    }
}
