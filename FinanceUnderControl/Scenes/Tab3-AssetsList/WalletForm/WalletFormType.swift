//
//  WalletFormType.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/06/2022.
//

import Foundation
import Shared

enum WalletFormType {
    case new(Currency? = nil)
    case edit(Wallet)

    var isEdit: Bool {
        if case .edit = self { return true }
        return false
    }

    var balance: Decimal? {
        if case let .edit(wallet) = self {
            return wallet.balance
        }
        return nil
    }

    var title: String {
        switch self {
        case .new:
            return .wallet_form_add_wallet_title
        case .edit:
            return .wallet_form_edit_wallet_title
        }
    }

    var confirmButtonTitle: String {
        switch self {
        case .new:
            return .button_create
        case .edit:
            return .common_save
        }
    }
}
