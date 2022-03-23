//
//  ExchangeRateEntity+Model.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Domain
import Foundation

public extension ExchangeRateEntity {
    struct Model {
        public let code: String
        public let rateValue: Double
        public let baseCurrency: String

        public init(code: String, rateValue: Double, baseCurrency: String) {
            self.code = code
            self.rateValue = rateValue
            self.baseCurrency = baseCurrency
        }
    }
}

extension ExchangeRate {
    func exchangeRateData(baseCurrency: String) -> ExchangeRateEntity.Model {
        ExchangeRateEntity.Model(code: code, rateValue: rate, baseCurrency: baseCurrency)
    }
}

// MARK: - Sample Data

extension ExchangeRateEntity.Model {
    static let plnInEur = ExchangeRateEntity.Model(code: "PLN", rateValue: 4, baseCurrency: "EUR")
    static let eurInPln = ExchangeRateEntity.Model(code: "EUR", rateValue: 1, baseCurrency: "PLN")
    static let usdInPln = ExchangeRateEntity.Model(code: "USD", rateValue: 1, baseCurrency: "PLN")
    static let eurInPln2 = ExchangeRateEntity.Model(code: "EUR", rateValue: 2, baseCurrency: "PLN")
    static let usdInPln2 = ExchangeRateEntity.Model(code: "USD", rateValue: 2, baseCurrency: "PLN")
}
