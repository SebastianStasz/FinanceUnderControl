//
//  CashFlow+Order.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 11/05/2022.
//

import Foundation

extension CashFlow {

    enum Order: DocumentFieldOrder {
        case name(SortOrder = .forward)
        case date(SortOrder = .reverse)

        var orderField: OrderField {
            switch self {
            case let .name(order):
                return .init(name: Field.nameLowercase.key, order: order)
            case let .date(order):
                return .init(name: Field.date.key, order: order)
            }
        }
    }
}
