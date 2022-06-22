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
    let percentageShare: Int?
}

extension AssetVD {
    init(from wallet: Wallet, total: Decimal?) {
        name = wallet.currency.code
        type = .wallet(wallet)
        money = wallet.money
        if let total = total, let balance = wallet.money.value(in: PersistentStorage.primaryCurrency)?.value {
            percentageShare = Int(((balance / total).asDouble * 100).rounded())
        } else {
            percentageShare = nil
        }
    }
}
