//
//  CurrencyData.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Foundation

public struct CurrencyData {
    public let code: String
    public let name: String
}

extension CurrencyData: Equatable {}

// MARK: - Sample Data

public extension CurrencyData {
    static let eur = CurrencyData(code: "EUR", name: "Euro")
    static let pln = CurrencyData(code: "PLN", name: "Polish złoty")
    static let usd = CurrencyData(code: "USD", name: "United States dollar")
}
