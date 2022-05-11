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
    func filter(by filter: FirestoreServiceFilter) -> Query {
        switch filter {
        case let .isEqual(field, value):
            return self.whereField(field, isEqualTo: value)
        case let .contains(field, value):
            return self.whereField(field, isGreaterThanOrEqualTo: value).whereField(field, isLessThanOrEqualTo: value + "~")
        }
    }
}
