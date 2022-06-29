//
//  CashFlowCategoryGroupSubscription.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/06/2022.
//

import FirebaseFirestore

final class CashFlowCategoryGroupSubscription {
    private let firestore = FirestoreService.shared
    private var listenerRegistration: ListenerRegistration?

    @Published private(set) var groups: [CashFlowCategoryGroup] = []

    func subscribe() {
        guard listenerRegistration == nil else { return }

        let configuration = QueryConfiguration<CashFlowCategoryGroup>(sorters: [CashFlowCategoryGroup.Order.name()])
        let subscriptionData = firestore.subscribe(to: .cashFlowCategoryGroups, configuration: configuration)
        let subscription = subscriptionData.1
        let groups = subscription.output
            .map { $0.map { CashFlowCategoryGroup(from: $0) } }
            .eraseToAnyPublisher()

        listenerRegistration = subscriptionData.0
        FirestoreSubscription(output: groups, firstDocument: subscription.firstDocument, lastDocument: subscription.lastDocument, error: subscription.error)
            .output.assign(to: &$groups)
    }

    func unsubscribe() {
        listenerRegistration?.remove()
        listenerRegistration = nil
        groups = []
    }
}
