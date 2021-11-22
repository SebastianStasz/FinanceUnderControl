//
//  Exchangerate.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Foundation

public struct Exchangerate: Decodable {
    public let currencies: [Currency]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let symbols = try container.decode([String:Symbol].self, forKey: .symbols)
        currencies = symbols.map { Currency(code: $1.code, name: $1.description) }
    }

    private enum CodingKeys: CodingKey {
        case symbols
    }

    private struct Symbol: Decodable {
        let description: String
        let code: String
    }
}
