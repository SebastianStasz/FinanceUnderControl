//
//  CashFlowCategorySubscription.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/06/2022.
//

import FirebaseFirestore
import SSUtils

final class CashFlowCategorySubscription {
    private let firestore = FirestoreService.shared
    private var listenerRegistration: ListenerRegistration?

    @Published private(set) var categories: [CashFlowCategory] = []

    func subscribe(groups: Driver<[CashFlowCategoryGroup]>) {
        guard listenerRegistration == nil else { return }

        let configuration = QueryConfiguration<CashFlowCategory>(sorters: [CashFlowCategory.Order.name()])
        let subscriptionData = firestore.subscribe(to: .cashFlowCategories, configuration: configuration)
        let subscription = subscriptionData.1
        let categories = CombineLatest(subscription.output, groups)
            .map { result in
                result.0.map { doc -> CashFlowCategory in
                    let groupId = doc.getOptionalString(for: CashFlowCategory.Field.groupId)
                    let group = result.1.first(where: { $0.id == groupId })
                    return CashFlowCategory(from: doc, group: group)
                }
            }
            .eraseToAnyPublisher()

        listenerRegistration = subscriptionData.0
        FirestoreSubscription(output: categories, firstDocument: subscription.firstDocument, lastDocument: subscription.lastDocument, error: subscription.error)
            .output.assign(to: &$categories)
    }

    func unsubscribe() {
        listenerRegistration?.remove()
        listenerRegistration = nil
        categories = []
    }
}
