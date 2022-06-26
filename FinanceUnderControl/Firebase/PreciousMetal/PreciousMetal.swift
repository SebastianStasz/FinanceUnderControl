//
//  PreciousMetal.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/06/2022.
//

import FirebaseFirestore
import Foundation
import Shared

struct PreciousMetal: FirestoreDocument {
    let type: PreciousMetalType
    let lastChangeDate: Date
    let ouncesAmount: Decimal

    var id: String {
        type.code
    }

    var amount: String {
        "\(ouncesAmount.asString) oz"
    }

    enum Field: String, DocumentField {
        case id, type, lastChangeDate, ouncesAmount
    }

    var data: [String: Any] {
        [Field.id.key: type.code,
         Field.type.key: type.code,
         Field.lastChangeDate.key: lastChangeDate,
         Field.ouncesAmount.key: ouncesAmount.asString]
    }

    func moneyInCurrency(_ currency: Currency) -> Money? {
        // TODO: Temporary value
        Money(ouncesAmount * 8200, currency: currency)
    }
}

extension PreciousMetal {
    init(from document: QueryDocumentSnapshot) {
        type = PreciousMetalType(rawValue: document.getString(for: Field.type))!
        lastChangeDate = document.getDate(for: Field.lastChangeDate)
        ouncesAmount = document.getDecimal(for: Field.ouncesAmount)
    }
}
