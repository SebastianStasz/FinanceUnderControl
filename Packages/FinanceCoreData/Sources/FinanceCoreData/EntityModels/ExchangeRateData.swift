//
//  ExchangeRateData.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Foundation

public struct ExchangeRateData {
    public let code: String
    public let rateValue: Double
    public let baseCurrency: CurrencyEntity
}
