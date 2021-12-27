//
//  CashFlowCategoryEntity+Sort.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public extension CashFlowCategoryEntity {

    enum Sort: EntitySort {
        case byName(SortOrder = .forward)

        public var get: SortDescriptor<Entity> {
            switch self {
            case let .byName(order):
                return SortDescriptor(\Entity.name, order: order)
            }
        }

        public typealias Entity = CashFlowCategoryEntity
    }
}
