//
//  CashFlowCategoryGroup+Order.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 11/05/2022.
//

import Foundation

extension CashFlowCategoryGroup {

    enum Order: DocumentOrder {
        case name(SortOrder = .forward)

        var orderField: OrderField<CashFlowCategoryGroup> {
            switch self {
            case let .name(order):
                return .init(field: .name, order: order)
            }
        }
    }
}
