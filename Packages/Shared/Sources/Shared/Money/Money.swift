//
//  Money.swift
//  Shared
//
//  Created by sebastianstaszczyk on 16/04/2022.
//

import Foundation

public struct Money: Equatable {
    public let value: Decimal
    public let currency: Currency

    public init(_ value: Decimal, currency: Currency) {
        self.value = value
        self.currency = currency
    }

    public var asString: String {
        value.formatted(for: currency, withSymbol: true)
    }

    fileprivate static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}

public extension Decimal {
    func formatted(for currency: Currency, withSymbol: Bool = false) -> String {
        let formatter = Money.formatter
        formatter.currencyCode = currency.code
        formatter.locale = currency.locale ?? .current
        if !withSymbol {
            formatter.currencySymbol = ""
        }
        return formatter.string(for: self)!
    }
}
