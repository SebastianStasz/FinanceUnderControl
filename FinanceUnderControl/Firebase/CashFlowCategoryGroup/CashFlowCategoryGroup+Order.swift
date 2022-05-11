//
//  CashFlowCategoryGroup+Order.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 11/05/2022.
//

import Foundation

extension CashFlowCategoryGroup {

    enum Order: DocumentFieldOrder {
        case name(SortOrder = .forward)

        var orderField: OrderField {
            switch self {
            case let .name(order):
                return .init(name: Field.name.key, order: order)
            }
        }
    }
}