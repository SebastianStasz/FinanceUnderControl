//
//  CashFlowCategoryGroupEntity+Sort.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//

import Foundation

public extension CashFlowCategoryGroupEntity {

    enum Sort: EntitySort {
        case byName(SortOrder = .forward)

        public var get: SortDescriptor<Entity> {
            switch self {
            case let .byName(order):
                return SortDescriptor(\Entity.name, order: order)
            }
        }

        public typealias Entity = CashFlowCategoryGroupEntity
    }
}
