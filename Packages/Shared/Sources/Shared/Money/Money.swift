//
//  Money.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import Foundation

public struct Money {
    public let value: Decimal
    public let currency: Currency

    public init(_ value: Decimal, currency: Currency) {
        self.value = value
        self.currency = currency
    }

    private static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}

public extension Money {

    var asString: String {
        let formatter = Money.formatter
        formatter.currencyCode = currency.code
        formatter.locale = currency.locale ?? .current
        return formatter.string(for: value)!
    }
}
