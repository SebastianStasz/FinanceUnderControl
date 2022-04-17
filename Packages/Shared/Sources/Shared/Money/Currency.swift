//
//  Currency.swift
//  Shared
//
//  Created by sebastianstaszczyk on 27/03/2022.
//

import Foundation

public enum Currency: String, CaseIterable {
    case BYN
    case EUR
    case GBP
    case PLN
    case RUB
    case UAH
    case USD
}

public extension Currency {

    var code: String {
        rawValue
    }

    var name: String {
        switch self {
        case .BYN:
            return "currency_BYN"
        case .EUR:
            return "currency_EUR"
        case .GBP:
            return "currency_GBP"
        case .PLN:
            return "currency_PLN"
        case .RUB:
            return "currency_RUB"
        case .UAH:
            return "currency_UAH"
        case .USD:
            return "currency_USD"
        }
    }

    var symbol: String {
        switch self {
        case .BYN:
            return "Br"
        case .EUR:
            return "€"
        case .GBP:
            return "£"
        case .PLN:
            return "zł"
        case .RUB:
            return "₽"
        case .UAH:
            return "₴"
        case .USD:
            return "$"
        }
    }

    var localeID: String? {
        switch self {
        case .BYN:
            return "by"
        case .GBP:
            return "gb"
        case .PLN:
            return "pl"
        case .RUB:
            return "re"
        case .UAH:
            return "ua"
        default:
            return nil
        }
    }

    var locale: Locale? {
        guard let id = localeID else { return nil }
        return Locale(identifier: id)
    }
}
