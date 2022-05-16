//
//  CashFlowService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import Combine
import Foundation
import FirebaseFirestore
import SSUtils

final class CashFlowService: CollectionService {
    typealias Document = CashFlow

    private let firestore = FirestoreService.shared
    private let storage = CashFlowGroupingService.shared
    private let categoryService = CashFlowCategoryService()
    private var lastDocument: QueryDocumentSnapshot?

    func createOrEdit(_ model: CashFlow) async throws {
        try await firestore.createOrEditDocument(withId: model.id, in: .cashFlows, data: model.data)
    }

    func delete(_ cashFlow: CashFlow) async throws {
        try await firestore.deleteDocument(withId: cashFlow.id, from: .cashFlows)
    }

    func subscribe() -> FirestoreSubscription<[CashFlow]> {
        let subscription = firestore.subscribe(to: .cashFlows, orderedBy: Order.date(), lastDocument: lastDocument)
        let cashFlows = CombineLatest(subscription.output, storage.$categories)
            .map { result in
                result.0.compactMap { doc -> CashFlow? in
                    let categoryId = doc.getString(for: Field.categoryId)
                    guard let category = result.1.first(where: { $0.id == categoryId }) else { return nil }
                    return CashFlow(from: doc, category: category)
                }
            }
            .eraseToAnyPublisher()
        return .init(output: cashFlows, error: subscription.error)
    }

    func fetch(filters: [Document.Filter]) async throws -> [CashFlow] {
        let docs = try await firestore.getDocuments(from: .cashFlows, orderedBy: Order.name(), filteredBy: filters.map { $0.predicate }, lastDocument: lastDocument)
        lastDocument = docs.last
        return docs.map {
            let categoryId = $0.getString(for: Field.categoryId)

            guard let category = storage.categories.first(where: { $0.id == categoryId }) else {
                return nil
            }
            return CashFlow(from: $0, category: category)
        }
        .compactMap { $0 }
    }
}
