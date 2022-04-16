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
        case typeIs(CashFlowType)
        case group(Group)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .typeIs(type):
                return NSPredicate(format: "type_ == %@", type.rawValue)
            case let .group(groupType):
                return groupType.nsPredicate
            }
        }
    }

    enum Group {
        case isNotWithName(String)
        case `is`(CashFlowCategoryGroupEntity)
        case ungrouped

        var nsPredicate: NSPredicate {
            switch self {
            case let .isNotWithName(groupName):
                return NSPredicate(format: "group.name != %@ OR group = nil", groupName)
            case let .is(group):
                return NSPredicate(format: "group == %@", group)
            case .ungrouped:
                return NSPredicate(format: "group = nil")
            }
        }
    }
}
