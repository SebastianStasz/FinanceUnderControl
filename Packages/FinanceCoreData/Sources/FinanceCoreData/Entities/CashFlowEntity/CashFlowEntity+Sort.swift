//
//  CashFlowEntity+Sort.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public extension CashFlowEntity {

    enum Sort: EntitySort {
        case byName(SortOrder = .forward)
        case byDate(SortOrder = .forward)

        public var get: SortDescriptor<Entity> {
            switch self {
            case let .byName(order):
                return SortDescriptor(\Entity.name, order: order)
            case let .byDate(order):
                return SortDescriptor(\Entity.date, order: order)
            }
        }

        public typealias Entity = CashFlowEntity
    }
}
