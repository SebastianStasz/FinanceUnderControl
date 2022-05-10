//
//  CashFlowService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import Combine
import Foundation
import FirebaseFirestore

final class CashFlowService: CollectionService {
    typealias Document = CashFlow
    typealias Field = Document.Field

    private let firestore = FirestoreService.shared
    private let storage = Storage.shared
    private let categoryService = CashFlowCategoryService()
    private var lastDocument: QueryDocumentSnapshot?

    func create(model: CashFlow) async throws {
        try await firestore.createDocument(in: .cashFlows, withId: model.id, data: model.data)
    }

    func delete(_ cashFlow: CashFlow) async throws {
        try await firestore.deleteDocument(withId: cashFlow.id, from: .cashFlows)
    }

    func subscribe() -> FirestoreService.Subscription<[CashFlow]> {
        let subscription = firestore.subscribe(to: .cashFlows, lastDocument: lastDocument, orderedBy: orderField)
        let cashFlows = subscription.output
            .map { $0.map { CashFlow(from: $0, category: .init(id: "1", name: "Test", type: .expense, icon: .airplane, groupId: nil)) } }
            .eraseToAnyPublisher()

        return .init(output: cashFlows, error: subscription.error)
    }

    func fetch() async throws -> [CashFlow] {
        let docs = try await firestore.getDocuments(from: .cashFlows, lastDocument: lastDocument, orderedBy: orderField)
        lastDocument = docs.last
        return try await docs.asyncMap {
            try await storage.updateCashFlowCategoriesIfNeeded()
            let categoryId = $0.getString(for: Field.categoryId)

            guard let category = storage.cashFlowCategories.first(where: { $0.id == categoryId }) else {
                return nil
            }
            return CashFlow(from: $0, category: category)
        }
        .compactMap { $0 }
    }

    private var orderField: OrderField<Field> {
        OrderField(field: Field.date, order: .reverse)
    }
}
