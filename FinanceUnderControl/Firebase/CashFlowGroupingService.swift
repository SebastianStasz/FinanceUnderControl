//
//  CashFlowGroupingService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Combine
import Foundation
import Shared

final class CashFlowGroupingService {
    static let shared = CashFlowGroupingService()

    private let firestore = FirestoreService.shared

    @Published private(set) var groups: [CashFlowCategoryGroup] = []
    @Published private(set) var categories: [CashFlowCategory] = []

    private init() {
        subscribeGroups().output.assign(to: &$groups)
        subscribeCategories().output.assign(to: &$categories)
    }

    func groups(type: CashFlowType) -> AnyPublisher<[CashFlowCategoryGroup], Never> {
        $groups.map { $0.filter { $0.type == type } }.eraseToAnyPublisher()
    }

    func categories(type: CashFlowType) -> AnyPublisher<[CashFlowCategory], Never> {
        $categories.map { $0.filter { $0.type == type } }.eraseToAnyPublisher()
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
        let categories = Publishers.CombineLatest(subscription.output, $groups)
            .map { result in
                result.0.map { doc -> CashFlowCategory in
                    let groupId = doc.getOptionalString(for: CashFlowCategory.Field.groupId)
                    let group = result.1.first(where: { $0.id == groupId })
                    return CashFlowCategory(from: doc, group: group)
                }
            }
            .eraseToAnyPublisher()

        return .init(output: categories, error: subscription.error)
    }
}
