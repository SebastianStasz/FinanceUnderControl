//
//  Wallet+Filter.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation
import Shared

extension Wallet {

    enum Filter: DocumentFilter {
        case isCurrency(Currency)

        var predicate: FirestoreServiceFilter {
            switch self {
            case let .isCurrency(currency):
                return .isEqual(field: Field.currency.key, value: currency.code)
            }
        }
    }
}
