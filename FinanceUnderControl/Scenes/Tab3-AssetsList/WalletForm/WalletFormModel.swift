//
//  WalletFormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/06/2022.
//

import Foundation
import Shared

struct WalletFormModel: Equatable {
    let lastUpdateDate: Date?
    var currency: Currency?
    var balance: Decimal?

    init(for formType: WalletFormType) {
        switch formType {
        case .new(let currency):
            lastUpdateDate = nil
            self.currency = currency
        case .edit(let wallet):
            lastUpdateDate = wallet.balanceDate
            currency = wallet.currency
            balance = wallet.balance
        }
    }

    var isValid: Bool {
        guard let balance = balance, balance >= 0, currency.notNil else {
            return false
        }
        return true
    }

    func model(for formType: WalletFormType) -> Wallet? {
        guard let currency = currency, let balance = balance, balance >= 0 else { return nil }
        switch formType {
        case .new:
            return Wallet(currency: currency, balanceDate: .now, balance: balance)
        case let .edit(wallet):
            return Wallet(currency: wallet.currency, balanceDate: .now, balance: balance)
        }
    }
}
