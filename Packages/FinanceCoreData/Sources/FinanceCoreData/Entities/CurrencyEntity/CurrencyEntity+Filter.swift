//
//  CurrencyEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Foundation

public extension CurrencyEntity {
    
    enum Filter: EntityFilter {
        case codeIs(String)
        case codeContains(String)
        case nameContains(String)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .codeIs(code):
                return NSPredicate(format: "code == %@", code)
            case let .codeContains(code):
                return NSPredicate(format: "code CONTAINS[cd] %@", code)
            case let .nameContains(name):
                return NSPredicate(format: "name_ CONTAINS[cd] %@", name)
            }
        }
    }
}
