//
//  ExchangeRateEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Foundation

public extension ExchangeRateEntity {
    
    enum Filter: EntityFilter {
        case byCode(String)

        public var nsPredicate: NSPredicate? {
            switch self {
            case let .byCode(code):
                return NSPredicate(format: "code == %@", code)
            }
        }
    }
}
