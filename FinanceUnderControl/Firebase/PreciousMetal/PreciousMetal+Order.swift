//
//  PreciousMetal+Order.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 26/06/2022.
//

import Foundation

extension PreciousMetal {

    enum Order: DocumentOrder {
        case type(SortOrder = .forward)

        var orderField: OrderField<PreciousMetal> {
            switch self {
            case let .type(order):
                return .init(field: .type, order: order)
            }
        }
    }
}
