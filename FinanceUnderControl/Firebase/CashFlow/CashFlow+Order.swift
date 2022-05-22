//
//  CashFlow+Order.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 11/05/2022.
//

import Foundation

extension CashFlow {

    enum Order: DocumentOrder {
        case name(SortOrder = .forward)
        case date(SortOrder = .reverse)

        var orderField: OrderField<CashFlow> {
            switch self {
            case let .name(order):
                return .init(field: .nameLowercase, order: order)
            case let .date(order):
                return .init(field: .date, order: order)
            }
        }
    }
}
