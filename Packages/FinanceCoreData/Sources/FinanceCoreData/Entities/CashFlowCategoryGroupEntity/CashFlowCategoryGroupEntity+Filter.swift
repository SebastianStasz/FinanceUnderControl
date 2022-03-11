//
//  CashFlowCategoryGroupEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//

import Foundation

public extension CashFlowCategoryGroupEntity {

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
