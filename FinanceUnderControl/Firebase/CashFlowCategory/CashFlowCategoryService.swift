//
//  CashFlowCategoryService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import FirebaseFirestore
import Foundation

final class CashFlowCategoryService: CollectionService {
    typealias Document = CashFlowCategory

    private let firestore = FirestoreService.shared

    func subscribe() -> FirestoreService.Subscription<[CashFlowCategory]> {
        let subscription = firestore.subscribe(to: .cashFlowCategories, orderedBy: Order.name())
        let categories = subscription.output
            .map { $0.map { CashFlowCategory(from: $0) } }
            .eraseToAnyPublisher()

        return .init(output: categories, error: subscription.error)
    }

    func getAll() async throws -> [CashFlowCategory] {
        try await firestore.getDocuments(from: .cashFlowCategories, orderedBy: Order.name())
            .map { CashFlowCategory(from: $0) }
    }

    func create(_ category: CashFlowCategory) async throws {
        try await firestore.createDocument(in: .cashFlowCategories, withId: category.id, data: category.data)
    }

    func delete(_ category: CashFlowCategory) async throws {
        try await firestore.deleteDocument(withId: category.id, from: .cashFlowCategories)
    }
}
