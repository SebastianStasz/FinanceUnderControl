//
//  CurrencyEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Foundation

public extension CurrencyEntity {

    enum Filter: EntityFilter {
        case code(String)
        case codeContains(String)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .code(code):
                return predicateForCode(code)
            case let .codeContains(code):
                return predicateForCodeContains(code)
            }
        }
    }
}

// MARK: - Predicates

private extension CurrencyEntity {

    static func predicateForCode(_ code: String) -> NSPredicate {
        NSPredicate(format: "code == %@", code)
    }

    static func predicateForCodeContains(_ code: String) -> NSPredicate {
        NSPredicate(format: "code CONTAINS[cd] %@", code)
    }
}
