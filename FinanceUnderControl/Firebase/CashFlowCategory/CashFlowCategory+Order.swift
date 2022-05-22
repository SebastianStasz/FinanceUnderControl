//
//  CashFlowCategory+Order.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 11/05/2022.
//

import Foundation

extension CashFlowCategory {

    enum Order: DocumentFieldOrder {
        case name(SortOrder = .forward)

        var orderField: OrderField<CashFlowCategory> {
            switch self {
            case let .name(order):
                return .init(field: .name, order: order)
            }
        }
    }
}
