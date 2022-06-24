//
//  Asset.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 22/06/2022.
//

import Foundation
import Shared

enum Asset: Equatable {
    case wallet(Wallet, moneyPrimaryCurrency: Money?)
    case preciousMetal(PreciousMetal, moneyPrimaryCurrency: Money?)

    var moneyPrimaryCurrency: Money? {
        switch self {
        case let .wallet(_, moneyPrimaryCurrency):
            return moneyPrimaryCurrency
        case let .preciousMetal(_, moneyPrimaryCurrency):
            return moneyPrimaryCurrency
        }
    }

    var name: String {
        switch self {
        case let .wallet(wallet, _):
            return wallet.currency.code
        case let .preciousMetal(preciousMetal, _):
            return preciousMetal.type.name
        }
    }

    var amount: String {
        switch self {
        case let .wallet(wallet, _):
            return wallet.money.asString
        case let .preciousMetal(preciousMetal, _):
            return preciousMetal.amount
        }
    }

    var isMainWallet: Bool {
        guard case let .wallet(wallet, _) = self else { return false }
        return wallet.currency == PersistentStorage.primaryCurrency
    }
}
