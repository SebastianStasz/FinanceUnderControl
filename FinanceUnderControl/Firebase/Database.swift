//
//  Database.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation

final class Database {
    static let shared = Database()

    private init() {}

    let grouping = CashFlowGroupingService()
    let wallets = WalletService()
}
