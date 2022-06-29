//
//  WalletSubscription.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/06/2022.
//

import FirebaseFirestore

final class WalletSubscription {
    private let firestore = FirestoreService.shared
    private var listenerRegistration: ListenerRegistration?

    @Published private(set) var wallets: [Wallet] = []

    func subscribe() {
        guard listenerRegistration == nil else { return }

        let configuration = QueryConfiguration<Wallet>(sorters: [Wallet.Order.currency()])
        let subscriptionData = firestore.subscribe(to: .wallets, configuration: configuration)
        let subscription = subscriptionData.1
        let wallets = subscription.output
            .map { $0.map { Wallet(from: $0) } }
            .eraseToAnyPublisher()

        listenerRegistration = subscriptionData.0
        FirestoreSubscription(output: wallets, firstDocument: subscription.firstDocument, lastDocument: subscription.lastDocument, error: subscription.error)
            .output.assign(to: &$wallets)
    }

    func unsubscribe() {
        listenerRegistration?.remove()
        listenerRegistration = nil
        wallets = []
    }
}
