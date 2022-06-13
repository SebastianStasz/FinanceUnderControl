//
//  Wallet+Order.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation

extension Wallet {

    enum Order: DocumentOrder {
        case currency(SortOrder = .forward)

        var orderField: OrderField<Wallet> {
            switch self {
            case let .currency(order):
                return .init(field: .currency, order: order)
            }
        }
    }
}
