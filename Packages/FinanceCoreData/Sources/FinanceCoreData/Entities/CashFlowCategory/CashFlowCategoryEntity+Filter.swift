//
//  CashFlowCategoryEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation
import Shared

public extension CashFlowCategoryEntity {

    enum Filter: EntityFilter {
        case type(CashFlowType)
        case groupNameIsNot(String)
        case ungrouped

        public var nsPredicate: NSPredicate {
            switch self {
            case let .type(type):
                return predicateForType(type)
            case let .groupNameIsNot(name):
                return predicateGroupNameIsNot(name)
            case .ungrouped:
                return predicateForUngrouped()
            }
        }
    }
}

private extension CashFlowCategoryEntity {

    static func predicateForType(_ type: CashFlowType) -> NSPredicate {
        NSPredicate(format: "type_ == %@", type.rawValue)
    }

    static func predicateGroupNameIsNot(_ name: String) -> NSPredicate {
        NSPredicate(format: "group.name != %@ OR group = nil", name)
    }

    static func predicateForUngrouped() -> NSPredicate {
        NSPredicate(format: "group = nil")
    }
}
