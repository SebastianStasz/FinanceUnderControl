//
//  CashFlow.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import FirebaseFirestore
import Foundation
import Shared

struct CashFlow: FirestoreDocument, CashFlowTypeSupport {
    let id: String
    let name: String
    let money: Money
    let date: Date
    let type: CashFlowType
    let category: CashFlowCategory
    let description: String?

    var nameLowercase: String {
        name.lowerCaseDiacriticInsensitive
    }

    enum Field: String, DocumentField {
        case id, name, amount, description
        case currency, categoryId, date, type
        case nameLowercase, year, month
    }

    var data: [String: Any] {
        [Field.id.key: id,
         Field.name.key: name.trim,
         Field.amount.key: money.value.asString,
         Field.currency.key: money.currency.rawValue,
         Field.categoryId.key: category.id,
         Field.date.key: date,
         Field.type.key: type.rawValue,
         Field.description.key: description as Any,
         Field.nameLowercase.key: name.lowerCaseDiacriticInsensitive,
         Field.year.key: date.year,
         Field.month.key: date.month]
    }

    var formModel: CashFlowFormModel {
        .init(date: date, name: name, value: money.value, description: description ?? "", currency: money.currency, category: category, type: category.type)
    }
}

extension CashFlow {
    init(from document: QueryDocumentSnapshot, category: CashFlowCategory) {
        let currency = document.getCurrency(for: Field.currency)
        let amount = document.getDecimal(for: Field.amount)
        id = document.getString(for: Field.id)
        name = document.getString(for: Field.name)
        money = Money(amount, currency: currency)
        type = CashFlowType(rawValue: document.getString(for: Field.type))!
        date = document.getDate(for: Field.date)
        description = document.getOptionalString(for: Field.description)
        self.category = category
    }
}
