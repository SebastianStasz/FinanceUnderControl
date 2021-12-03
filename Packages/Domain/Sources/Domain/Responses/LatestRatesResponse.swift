//
//  LatestRatesResponse.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 23/11/2021.
//

import Foundation

public struct LatestRatesResponse: Decodable {
    public let base: String
    public let dateStr: String
    public private(set) var rates: [ExchangeRate]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base = try container.decode(String.self, forKey: .base)
        let values = try container.decode([String:Double].self, forKey: .rates)

        self.base = base
        self.dateStr = try container.decode(String.self, forKey: .dateStr)
        self.rates = values.map { ExchangeRate(code: $0, rate: $1) }.filter { $0.code != base }
    }

    private enum CodingKeys: String, CodingKey {
        case base, rates
        case dateStr = "date"
    }
}

extension LatestRatesResponse: Equatable {}

extension LatestRatesResponse {
    init(base: String, dateStr: String, rates: [ExchangeRate]) {
        self.base = base
        self.dateStr = dateStr
        self.rates = rates
    }

    mutating func sortRates() {
        rates.sort(by: { $0.code < $1.code })
    }
}
