//
//  OrderField.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation

struct OrderField<T: FirestoreDocument> {
    let field: T.Field
    let order: SortOrder

    init(field: T.Field, order: SortOrder = .forward) {
        self.field = field
        self.order = order
    }

    func valueFrom(_ document: T) -> Any {
        document.data[field.key]!
    }
}
