//
//  CashFlowCategoryEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public extension CashFlowCategoryEntity {

    enum Filter: EntityFilter {
        case typeIs(CashFlowType)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .typeIs(type):
                return NSPredicate(format: "type_ == %@", type.rawValue)
            }
        }
    }
}
