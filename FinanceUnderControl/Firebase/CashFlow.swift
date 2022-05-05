//
//  CashFlow.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import Shared

struct CashFlow: FirestoreDocument, Identifiable {
    let name: String
    let money: Money
    let date: Date
    let categoryId: String

    var id: String {
        date.description + name
    }

    var data: [String: Any] {
        [Field.name.key: name,
         Field.amount.key: money.value,
         Field.currency.key: money.currency.rawValue,
         Field.categoryId.key: categoryId,
         Field.date.key: date]
    }

    enum Field: String, DocumentField {
        case name, amount, currency, categoryId, date
    }
}

extension CashFlow {
    init(from document: QueryDocumentSnapshot) {
        let currency = document.getCurrency(for: Field.currency)
        let amount = document.getDecimal(for: Field.amount)
        self.name = document.getString(for: Field.name)
        self.money = Money(amount, currency: currency)
        self.date = document.getDate(for: Field.date)
        self.categoryId = document.getString(for: Field.categoryId)
    }
}
