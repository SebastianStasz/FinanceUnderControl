//
//  QueryDocumentSnapshot+Get.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import FirebaseFirestore
import Foundation
import Shared

// TODO: Remove force unwrap and handle exceptions

extension DocumentSnapshot {
    func get<T: DocumentField>(_ field: T) -> Any? {
        get(field.rawValue)
    }

    func getString<T: DocumentField>(for field: T) -> String {
        get(field.rawValue) as! String
    }

    func getOptionalString<T: DocumentField>(for field: T) -> String? {
        get(field.rawValue) as? String
    }

    func getCurrency<T: DocumentField>(for field: T) -> Currency {
        let code = getString(for: field)
        return Currency(rawValue: code)!
    }

    func getDecimal<T: DocumentField>(for field: T) -> Decimal {
        let value = getString(for: field)
        return try! Decimal(value, format: .number)
    }

    func getDate<T: DocumentField>(for field: T) -> Date {
        let timestamp = get(field.rawValue) as! Timestamp
        return timestamp.dateValue()
    }

    func getStringArray<T: DocumentField>(for field: T) -> [String] {
        get(field) as! [String]
    }
}
