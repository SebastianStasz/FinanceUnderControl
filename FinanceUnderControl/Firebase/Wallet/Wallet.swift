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
    let balance: Decimal

    var id: String {
        currency.id
    }

    enum Field: String, DocumentField {
        case currency, balance
    }

    var data: [String: Any] {
        [Field.currency.key: currency.code,
         Field.balance.key: balance.asString]
    }
}

extension Wallet {
    init(from document: QueryDocumentSnapshot) {
        currency = document.getCurrency(for: Field.currency)
        balance = document.getDecimal(for: Field.balance)
    }
}
