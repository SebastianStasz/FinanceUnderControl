//
//  CurrencyEntity+Model.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 23/03/2022.
//

import Foundation
import Shared

public extension CurrencyEntity {

    struct Model {
        public let code: String
        public let nameKey: String

        public init(code: String, name: String) {
            self.code = code
            self.nameKey = name
        }
    }
}

public extension SupportedCurrency {
    var currencyEntityModel: CurrencyEntity.Model {
        .init(code: code, name: name)
    }

    static var currencyEntityModels: [CurrencyEntity.Model] {
        SupportedCurrency.allCases.map { $0.currencyEntityModel }
    }
}

// MARK: - Sample data

extension CurrencyEntity.Model {
    static let eur = CurrencyEntity.Model(code: "EUR", name: "Euro")
    static let pln = CurrencyEntity.Model(code: "PLN", name: "Polish złoty")
    static let usd = CurrencyEntity.Model(code: "USD", name: "United States dollar")
}
