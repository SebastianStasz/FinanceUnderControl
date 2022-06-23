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
    let amount: String
    let amountInPrimaryCurrency: String?
    let percentageShare: Int?
}

extension AssetVD {
    init(from wallet: Wallet, total: Decimal?) {
        name = wallet.currency.code
        type = .wallet(wallet)
        amount = wallet.money.asString

        if wallet.currency == PersistentStorage.primaryCurrency, let total = total {
            percentageShare = Int(((wallet.balance / total).asDouble * 100).rounded())
            amountInPrimaryCurrency = nil
        } else if let total = total, let balance = wallet.money.value(in: PersistentStorage.primaryCurrency)?.value {
            percentageShare = Int(((balance / total).asDouble * 100).rounded())
            amountInPrimaryCurrency = Money(balance, currency: PersistentStorage.primaryCurrency).asString
        } else {
            percentageShare = nil
            amountInPrimaryCurrency = nil
        }
    }

    init(from preciousMetal: PreciousMetal, total: Decimal?) {
        name = preciousMetal.type.name
        type = .preciousMetal(preciousMetal)
        amount = preciousMetal.ouncesAmount.asString

        if let total = total {
            let balance = preciousMetal.ouncesAmount * 8200
            percentageShare = Int(((balance / total).asDouble * 100).rounded())
            amountInPrimaryCurrency = Money(balance, currency: PersistentStorage.primaryCurrency).asString
        } else {
            percentageShare = nil
            amountInPrimaryCurrency = nil
        }
    }
}
