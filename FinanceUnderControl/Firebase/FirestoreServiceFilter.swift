//
//  FirestoreServiceFilter.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/05/2022.
//

import FirebaseFirestore
import Foundation

enum FirestoreServiceFilter {
    case isEqual(field: String, value: Any)
    case contains(field: String, value: String)
}

extension Query {
    func filter<T: DocumentFilter>(by filter: T) -> Query {
        switch filter.predicate {
        case let .isEqual(field, value):
            return whereField(field, isEqualTo: value)
        case let .contains(field, value):
            return whereField(field, isGreaterThanOrEqualTo: value).whereField(field, isLessThanOrEqualTo: value + "~")
        }
    }

    func order<T: DocumentOrder>(by sorter: T) -> Query {
        order(by: sorter.orderField.field.key, descending: sorter.orderField.order == .reverse)
    }

    func filter<T: DocumentFilter>(by filters: [T]) -> Query {
        var query = self
        filters.forEach { query = query.filter(by: $0) }
        return query
    }

    func order<T: DocumentOrder>(by sorters: [T]) -> Query {
        var query = self
        sorters.forEach { query = query.order(by: $0) }
        return query
    }
}
