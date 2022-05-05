//
//  CashFlow.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import FirebaseFirestore
import Foundation
import Shared

struct CashFlow: FirestoreDocument, Identifiable, Equatable {
    let name: String
    let money: Money
    let date: Date
    let category: CashFlowCategory

    var id: String {
        date.description + name
    }

    var data: [String: Any] {
        [Field.name.key: name,
         Field.amount.key: money.value.asString,
         Field.currency.key: money.currency.rawValue,
         Field.categoryId.key: category.id,
         Field.date.key: date]
    }

    enum Field: String, DocumentField {
        case name, amount, currency, categoryId, date
    }
}

extension CashFlow {
    init(from document: QueryDocumentSnapshot, category: CashFlowCategory) {
        let currency = document.getCurrency(for: Field.currency)
        let amount = document.getDecimal(for: Field.amount)
        name = document.getString(for: Field.name)
        money = Money(amount, currency: currency)
        date = document.getDate(for: Field.date)
        self.category = category
    }
}
