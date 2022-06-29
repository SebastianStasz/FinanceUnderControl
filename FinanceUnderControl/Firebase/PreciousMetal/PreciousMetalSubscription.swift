//
//  PreciousMetalSubscription.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/06/2022.
//

import FirebaseFirestore

final class PreciousMetalSubscription {
    private let firestore = FirestoreService.shared
    private var listenerRegistration: ListenerRegistration?

    @Published private(set) var preciousMetals: [PreciousMetal] = []

    func subscribe() {
        guard listenerRegistration == nil else { return }

        let configuration = QueryConfiguration<PreciousMetal>(sorters: [PreciousMetal.Order.type()])
        let subscriptionData = firestore.subscribe(to: .preciousMetals, configuration: configuration)
        let subscription = subscriptionData.1
        let preciousMetals = subscription.output
            .map { $0.map { PreciousMetal(from: $0) } }
            .eraseToAnyPublisher()

        listenerRegistration = subscriptionData.0
        FirestoreSubscription(output: preciousMetals, firstDocument: subscription.firstDocument, lastDocument: subscription.lastDocument, error: subscription.error)
            .output.assign(to: &$preciousMetals)
    }

    func unsubscribe() {
        listenerRegistration?.remove()
        listenerRegistration = nil
        preciousMetals = []
    }
}
