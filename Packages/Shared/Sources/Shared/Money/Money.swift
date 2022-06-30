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

public extension Optional where Wrapped == Money {
    static func +(lhs: Money?, rhs: Money?) -> Money? {
        guard let lhs = lhs, let rhs = rhs, lhs.currency == rhs.currency else { return nil }
        return Money(lhs.value + rhs.value, currency: lhs.currency)
    }

    static func -(lhs: Money?, rhs: Money?) -> Money? {
        guard let lhs = lhs, let rhs = rhs, lhs.currency == rhs.currency else { return nil }
        return Money(lhs.value - rhs.value, currency: lhs.currency)
    }

    static func /(lhs: Money?, rhs: Money?) -> Money? {
        guard let lhs = lhs, let rhs = rhs, lhs.currency == rhs.currency else { return nil }
        return Money(lhs.value / rhs.value, currency: lhs.currency)
    }
}

public extension Array where Element == Money? {
    func sum() -> Money? {
        notContains(nil) ? compactMap { $0 }.sum() : nil
    }
}

public extension Array where Element == Money {
    func sum() -> Money? {
        guard let currency = first?.currency, allSatisfy({ $0.currency == currency }) else { return nil }
        let value = map { $0.value }.reduce(0, +)
        return Money(value, currency: currency)
    }
}
