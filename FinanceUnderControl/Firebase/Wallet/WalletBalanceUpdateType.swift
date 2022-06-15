//
//  WalletBalanceUpdateType.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation
import Shared

enum WalletBalanceUpdateType {
    case new(CashFlow)
    case delete(CashFlow)
    case edit(CashFlow, oldValue: Decimal)

    var currency: Currency {
        switch self {
        case let .new(cashFlow):
            return cashFlow.money.currency
        case let .delete(cashFlow):
            return cashFlow.money.currency
        case let .edit(cashFlow, _):
            return cashFlow.money.currency
        }
    }

    var cashFlow: CashFlow {
        switch self {
        case let .new(cashFlow):
            return cashFlow
        case let .delete(cashFlow):
            return cashFlow
        case let .edit(cashFlow, _):
            return cashFlow
        }
    }

    func newBalance(for wallet: Wallet) -> Decimal {
        switch self {
        case let .new(cashFlow):
            return wallet.balance + (cashFlow.isIncome ? cashFlow.value : -cashFlow.value)
        case let .delete(cashFlow):
            return wallet.balance + (cashFlow.isIncome ? -cashFlow.value : cashFlow.value)
        case let .edit(cashFlow, oldValue):
            let balance = wallet.balance + (cashFlow.isIncome ? -oldValue : oldValue)
            return balance + (cashFlow.isIncome ? cashFlow.value : -cashFlow.value)
        }
    }
}
