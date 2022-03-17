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
        case groupIs(Group)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .typeIs(type):
                return NSPredicate(format: "type_ == %@", type.rawValue)
            case let .groupIs(groupType):
                return groupType.nsPredicate
            }
        }
    }

    enum Group {
        case group(CashFlowCategoryGroupEntity)
        case ungrouped

        var nsPredicate: NSPredicate {
            switch self {
            case let .group(group):
                return NSPredicate(format: "group == %@", group)
            case .ungrouped:
                return NSPredicate(format: "group = nil")
            }
        }
    }
}
