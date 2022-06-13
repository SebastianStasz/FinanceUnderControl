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

    private let firestore = FirestoreService.shared

    @Published private(set) var groups: [CashFlowCategoryGroup] = []
    @Published private(set) var categories: [CashFlowCategory] = []

    init() {
        subscribeGroups().output.assign(to: &$groups)
        subscribeCategories().output.assign(to: &$categories)
    }

    func groupsSubscription(type: CashFlowType) -> AnyPublisher<[CashFlowCategoryGroup], Never> {
        $groups.map { $0.filter { $0.type == type } }.eraseToAnyPublisher()
    }

    func categoriesSubscription(type: CashFlowType) -> AnyPublisher<[CashFlowCategory], Never> {
        $categories.map { $0.filter { $0.type == type } }.eraseToAnyPublisher()
    }

    func groups(type: CashFlowType) -> [CashFlowCategoryGroup] {
        groups.filter { $0.type == type }
    }

    func categories(type: CashFlowType) -> [CashFlowCategory] {
        categories.filter { $0.type == type }
    }

    private func subscribeGroups() -> FirestoreSubscription<[CashFlowCategoryGroup]> {
        let configuration = QueryConfiguration<CashFlowCategoryGroup>(sorters: [CashFlowCategoryGroup.Order.name()])
        let subscription = firestore.subscribe(to: .cashFlowCategoryGroups, configuration: configuration)
        let groups = subscription.output
            .map { $0.map { CashFlowCategoryGroup(from: $0) } }
            .eraseToAnyPublisher()

        return .init(output: groups, firstDocument: subscription.firstDocument, lastDocument: subscription.lastDocument, error: subscription.error)
    }

    private func subscribeCategories() -> FirestoreSubscription<[CashFlowCategory]> {
        let configuration = QueryConfiguration<CashFlowCategory>(sorters: [CashFlowCategory.Order.name()])
        let subscription = firestore.subscribe(to: .cashFlowCategories, configuration: configuration)
        let categories = Publishers.CombineLatest(subscription.output, $groups)
            .map { result in
                result.0.map { doc -> CashFlowCategory in
                    let groupId = doc.getOptionalString(for: CashFlowCategory.Field.groupId)
                    let group = result.1.first(where: { $0.id == groupId })
                    return CashFlowCategory(from: doc, group: group)
                }
            }
            .eraseToAnyPublisher()

        return .init(output: categories, firstDocument: subscription.firstDocument, lastDocument: subscription.lastDocument, error: subscription.error)
    }
}
