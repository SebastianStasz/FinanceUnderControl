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
    let id: String
    let currency: Currency
    let balance: Decimal

    enum Field: String, DocumentField {
        case id, currency, balance
    }

    var data: [String: Any] {
        [Field.currency.key: currency.code,
         Field.balance.key: balance.asString]
    }
}

extension Wallet {
    init(from document: QueryDocumentSnapshot) {
        id = document.getString(for: Field.id)
        currency = document.getCurrency(for: Field.currency)
        balance = document.getDecimal(for: Field.balance)
    }
}
