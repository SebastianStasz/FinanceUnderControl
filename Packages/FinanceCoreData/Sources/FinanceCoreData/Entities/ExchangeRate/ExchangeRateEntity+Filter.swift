//
//  ExchangeRateEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Foundation

public extension ExchangeRateEntity {

    enum Filter: EntityFilter {
        case code(String)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .code(code):
                return predicateForCode(code)
            }
        }
    }
}

// MARK: - Predicates

private extension ExchangeRateEntity {

    static func predicateForCode(_ code: String) -> NSPredicate {
        NSPredicate(format: "code == %@", code)
    }
}
