//
//  CashFlowEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public extension CashFlowEntity {

    enum Filter: EntityFilter {
        case byType(CashFlowCategoryType)

        public var nsPredicate: NSPredicate? {
            switch self {
            case let .byType(type):
                return NSPredicate(format: "category.type_ == %@", type.name)
            }
        }
    }
}
