//
//  CashFlowCategoryGroupEntity+Sort.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//

import Foundation

public extension CashFlowCategoryGroupEntity {

    enum Sort: EntitySort {

        public var get: SortDescriptor<Entity> {
            switch self {
            }
        }

        public typealias Entity = CashFlowCategoryGroupEntity
    }
}
