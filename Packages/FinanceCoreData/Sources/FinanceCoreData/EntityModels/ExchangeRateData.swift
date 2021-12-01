//
//  ExchangeRateData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Domain
import Foundation

public struct ExchangeRateData {
    public let code: String
    public let rateValue: Double
    public let baseCurrency: String

    public init(code: String, rateValue: Double, baseCurrency: String) {
        self.code = code
        self.rateValue = rateValue
        self.baseCurrency = baseCurrency
    }
}

extension ExchangeRate {
    func exchangeRateData(baseCurrency: String) -> ExchangeRateData {
        ExchangeRateData(code: code, rateValue: rate, baseCurrency: baseCurrency)
    }
}


// MARK: - Sample Data

extension ExchangeRateData {
    static let plnInEur = ExchangeRateData(code: "PLN", rateValue: 4, baseCurrency: "EUR")
    static let eurInPln = ExchangeRateData(code: "EUR", rateValue: 1, baseCurrency: "PLN")
    static let usdInPln = ExchangeRateData(code: "USD", rateValue: 1, baseCurrency: "PLN")
    static let eurInPln2 = ExchangeRateData(code: "EUR", rateValue: 2, baseCurrency: "PLN")
    static let usdInPln2 = ExchangeRateData(code: "USD", rateValue: 2, baseCurrency: "PLN")
}
