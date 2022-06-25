//
//  PreciousMetal.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/06/2022.
//

import Foundation
import Shared

struct PreciousMetal: Equatable {
    let type: PreciousMetalType
    let lastChangeDate: Date?
    let ouncesAmount: Decimal

    func moneyInCurrency(_ currency: Currency) -> Money? {
        // TODO: Temporary value
        Money(ouncesAmount * 8200, currency: currency)
    }

    var amount: String {
        "\(ouncesAmount.asString) oz"
    }
}
