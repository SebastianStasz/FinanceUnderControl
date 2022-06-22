//
//  AssetVD.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/06/2022.
//

import Foundation
import Shared

struct AssetVD: Identifiable, Equatable {
    let id = UUID().uuidString
    let type: Asset
    let name: String
    let money: Money
    let moneyInPrimaryCurrency: Money?
    let percentageShare: Int?
}

extension AssetVD {
    init(from wallet: Wallet, total: Decimal?) {
        name = wallet.currency.code
        type = .wallet(wallet)
        money = wallet.money

        if wallet.currency == PersistentStorage.primaryCurrency, let total = total {
            percentageShare = Int(((wallet.balance / total).asDouble * 100).rounded())
            moneyInPrimaryCurrency = nil
        } else if let total = total, let balance = wallet.money.value(in: PersistentStorage.primaryCurrency)?.value {
            percentageShare = Int(((balance / total).asDouble * 100).rounded())
            moneyInPrimaryCurrency = Money(balance, currency: PersistentStorage.primaryCurrency)
        } else {
            percentageShare = nil
            moneyInPrimaryCurrency = nil
        }
    }
}
