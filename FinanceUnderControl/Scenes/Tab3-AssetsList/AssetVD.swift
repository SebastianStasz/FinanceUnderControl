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
    let asset: Asset
    let name: String
    let amount: String
    let amountInPrimaryCurrency: String?
    let percentageShare: Int?
}

extension AssetVD {
    init(from asset: Asset, total: Money?) {
        self.asset = asset
        name = asset.name
        amount = asset.amount
        amountInPrimaryCurrency = asset.isMainWallet ? nil : asset.moneyPrimaryCurrency?.asString
        
        if let money = asset.moneyPrimaryCurrency / total {
            let value = money.value.asDouble * 100
            if value.isFinite && !value.isNaN {
                percentageShare = Int((value).rounded())
            } else {
                percentageShare = nil
            }
        } else {
            percentageShare = nil
        }
    }
}
