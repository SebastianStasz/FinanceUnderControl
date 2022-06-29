//
//  WalletService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation
import FirebaseFirestore
import Shared

final class WalletService {
    private let firestore = FirestoreService.shared
    private let storage = FirestoreStorage.shared

    func create(_ wallet: Wallet) async throws {
        try await firestore.createOrEditDocument(withId: wallet.id, in: .wallets, data: wallet.data)
    }

    func setBalance(_ balance: Decimal, for wallet: Wallet) async throws {
        try await firestore.edit(withId: wallet.id, in: .wallets, data: Wallet.balanceData(for: balance))
    }

    func updateBalance(for type: WalletBalanceUpdateType, using batch: WriteBatch) -> WriteBatch {
        let wallet = storage.currentWallets.first(where: { $0.currency == type.currency })! // TODO: Do not use force unwrap
        guard wallet.lastChangeDate < type.cashFlow.date else { return batch }
        let newBalance = type.newBalance(for: wallet)
        return firestore.edit(withId: wallet.id, in: .wallets, data: Wallet.balanceData(for: newBalance), batch: batch)
    }
}
