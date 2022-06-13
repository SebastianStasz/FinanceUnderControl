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
    static let shared = WalletService()
    private let firestore = FirestoreService.shared

    @Published private(set) var wallets: [Wallet] = []

    private init() {
        subscribeWallets().output.assign(to: &$wallets)
    }

    func updateBalance(for type: WalletBalanceUpdateType, using batch: WriteBatch) -> WriteBatch {
        let wallet = wallets.first(where: { $0.currency == type.currency })! // TODO: Do not use force unwrap
        let newBalance = type.newBalance(for: wallet)
        return firestore.edit(withId: wallet.id, in: .wallets, data: Wallet.balanceData(for: newBalance), batch: batch)
    }

    private func subscribeWallets() -> FirestoreSubscription<[Wallet]> {
        let configuration = QueryConfiguration<Wallet>(sorters: [Wallet.Order.currency()])
        let subscription = firestore.subscribe(to: .wallets, configuration: configuration)
        let wallets = subscription.output
            .map { $0.map { Wallet(from: $0) } }
            .eraseToAnyPublisher()

        return .init(output: wallets, firstDocument: subscription.firstDocument, lastDocument: subscription.lastDocument, error: subscription.error)
    }
}
