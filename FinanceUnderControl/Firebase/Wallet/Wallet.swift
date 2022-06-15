//
//  Wallet.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import FirebaseFirestore
import Foundation
import Shared

struct Wallet: FirestoreDocument {
    let currency: Currency
    let lastChangeDate: Date
    let balance: Decimal

    var id: String {
        currency.code
    }

    var money: Money {
        Money(balance, currency: currency)
    }

    enum Field: String, DocumentField {
        case id, currency, lastChangeDate, balance
    }

    var data: [String: Any] {
        [Field.id.key: currency.code,
         Field.currency.key: currency.code,
         Field.lastChangeDate.key: lastChangeDate,
         Field.balance.key: balance.asString]
    }

    static func balanceData(for balance: Decimal) -> [String: Any] {
        [Field.balance.key: balance.asString]
    }
}

extension Wallet {
    init(from document: QueryDocumentSnapshot) {
        currency = document.getCurrency(for: Field.currency)
        lastChangeDate = document.getDate(for: Field.lastChangeDate)
        balance = document.getDecimal(for: Field.balance)
    }
}
