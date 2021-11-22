//
//  CurrencyData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Foundation

public struct CurrencyData {
    public let name: String
    public let code: String

    public init(name: String, code: String) {
        self.name = name
        self.code = code
    }
}


// MARK: - Sample Data

extension CurrencyData {
    static let eur = CurrencyData(name: "Euro", code: "EUR")
    static let pln = CurrencyData(name: "Polish złoty", code: "PLN")
    static let usd = CurrencyData(name: "United States dollar", code: "USD")
}
