//
//  OrderField.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation

struct OrderField {
    let name: String
    let order: SortOrder

    init(name: String, order: SortOrder = .forward) {
        self.name = name
        self.order = order
    }
}
