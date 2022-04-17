//
//  CashFlowCategoryGroupEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//

import Foundation
import Shared

public extension CashFlowCategoryGroupEntity {

    enum Filter: EntityFilter {
        case name(String)
        case type(CashFlowType)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .name(name):
                return predicateForName(name)
            case let .type(type):
                return predicateForType(type)
            }
        }
    }
}

// MARK: - Predicates

private extension CashFlowCategoryGroupEntity {

    static func predicateForName(_ name: String) -> NSPredicate {
        NSPredicate(format: "name == %@", name)
    }

    static func predicateForType(_ type: CashFlowType) -> NSPredicate {
        NSPredicate(format: "type_ == %@", type.rawValue)
    }
}
