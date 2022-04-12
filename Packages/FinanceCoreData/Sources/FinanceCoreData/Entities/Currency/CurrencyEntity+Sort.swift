//
//  CurrencyEntity+Sort.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Foundation

public extension CurrencyEntity {

    enum Sort: EntitySort {
        case byCode(SortOrder = .forward)

        public var get: SortDescriptor<Entity> {
            switch self {
            case let .byCode(order):
                return SortDescriptor(\Entity.code, order: order)
            }
        }

        public typealias Entity = CurrencyEntity
    }
}
