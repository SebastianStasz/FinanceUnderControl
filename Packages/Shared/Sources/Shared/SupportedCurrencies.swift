//
//  SupportedCurrencies.swift
//  Shared
//
//  Created by sebastianstaszczyk on 27/03/2022.
//

import Foundation

enum SupportedCurrencies: String {
    case BYN
    case EUR
    case GBP
    case PLN
    case RUB
    case UAH
    case USD

    var name: String {
        switch self {
        case .BYN:
            return .currency_BYN
        case .EUR:
            return .currency_EUR
        case .GBP:
            return .currency_GBP
        case .PLN:
            return .currency_PLN
        case .RUB:
            return .currency_RUB
        case .UAH:
            return .currency_UAH
        case .USD:
            return .currency_USD
        }
    }
}
