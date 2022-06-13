//
//  WalletService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Foundation

final class WalletService {
    private let firestore = FirestoreService.shared

    @Published private(set) var wallets: [Wallet] = []

    init() {
        subscribeWallets().output.assign(to: &$wallets)
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
