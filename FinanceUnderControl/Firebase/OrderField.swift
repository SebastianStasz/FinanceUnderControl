//
//  OrderField.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation

struct OrderField<T: DocumentField> {
    let field: T
    let order: SortOrder

    init(field: T, order: SortOrder = .forward) {
        self.field = field
        self.order = order
    }
}
