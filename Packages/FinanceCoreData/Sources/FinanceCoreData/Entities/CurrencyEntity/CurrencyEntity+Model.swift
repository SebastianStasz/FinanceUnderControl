//
//  CurrencyEntity+Model.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 23/03/2022.
//

import Foundation

public extension CurrencyEntity {

    struct Model {
        public let code: String
        public let name: String

        public init(code: String, name: String) {
            self.code = code
            self.name = name
        }
    }
}

// MARK: - Sample data

extension CurrencyEntity.Model {
    static let eur = CurrencyEntity.Model(code: "EUR", name: "Euro")
    static let pln = CurrencyEntity.Model(code: "PLN", name: "Polish złoty")
    static let usd = CurrencyEntity.Model(code: "USD", name: "United States dollar")
}
