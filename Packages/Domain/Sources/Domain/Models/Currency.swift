//
//  Currency.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Foundation

public struct Currency {
    public let code: String
    public let name: String
}

extension Currency: Equatable {}

// MARK: - Sample Data

public extension Currency {
    static let eur = Currency(code: "EUR", name: "Euro")
    static let pln = Currency(code: "PLN", name: "Polish złoty")
    static let usd = Currency(code: "USD", name: "United States dollar")
}
