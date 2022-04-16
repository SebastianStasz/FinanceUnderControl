//
//  SymbolsReponse.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Foundation

public struct SymbolsReponse: Decodable {
    public private(set) var currencies: [CurrencyData]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let symbols = try container.decode([String: Symbol].self, forKey: .symbols)
        currencies = symbols.map { CurrencyData(code: $1.code, name: $1.description) }
    }

    private enum CodingKeys: CodingKey {
        case symbols
    }

    private struct Symbol: Decodable {
        let description: String
        let code: String
    }
}

extension SymbolsReponse: Equatable {}

extension SymbolsReponse {
    init(currencies: [CurrencyData]) {
        self.currencies = currencies
    }

    mutating func sortCurrencies() {
        currencies.sort(by: { $0.code < $1.code })
    }
}
