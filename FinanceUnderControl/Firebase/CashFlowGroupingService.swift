//
//  CashFlowGroupingService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Combine
import Foundation

final class CashFlowGroupingService {
    static let shared = CashFlowGroupingService()

    private let firestore = FirestoreService.shared

    @Published private(set) var cashFlowCategoryGroups: [CashFlowCategoryGroup] = []
    @Published private(set) var cashFlowCategories: [CashFlowCategory] = []

    private init() {
        subscribeGroups().output.assign(to: &$cashFlowCategoryGroups)
        subscribeCategories().output.assign(to: &$cashFlowCategories)
    }

    private func subscribeGroups() -> FirestoreService.Subscription<[CashFlowCategoryGroup]> {
        let subscription = firestore.subscribe(to: .cashFlowCategoryGroups, orderedBy: CashFlowCategoryGroup.Order.name())
        let groups = subscription.output
            .map { $0.map { CashFlowCategoryGroup(from: $0) } }
            .eraseToAnyPublisher()

        return .init(output: groups, error: subscription.error)
    }

    private func subscribeCategories() -> FirestoreService.Subscription<[CashFlowCategory]> {
        let subscription = firestore.subscribe(to: .cashFlowCategories, orderedBy: CashFlowCategory.Order.name())
        let categories = Publishers.CombineLatest(subscription.output, $cashFlowCategoryGroups)
            .map { result in
                result.0.map { doc -> CashFlowCategory in
                    let groupId = doc.getOptionalString(for: CashFlowCategoryGroup.Field.id)
                    let group = result.1.first(where: { $0.id == groupId })
                    return CashFlowCategory(from: doc, group: group)
                }
            }
            .eraseToAnyPublisher()

        return .init(output: categories, error: subscription.error)
    }
}
