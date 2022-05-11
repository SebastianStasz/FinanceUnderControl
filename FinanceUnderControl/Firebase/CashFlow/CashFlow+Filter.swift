//
//  CashFlow+Filter.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/05/2022.
//

import Foundation

extension CashFlow {

    enum Filter {
        case nameContains(String)

        var predicate: FirestoreServiceFilter {
            switch self {
            case let .nameContains(text):
                return .contains(field: Field.nameLowercase.key, value: text.lowerCaseDiacriticInsensitive)
            }
        }
    }
}
