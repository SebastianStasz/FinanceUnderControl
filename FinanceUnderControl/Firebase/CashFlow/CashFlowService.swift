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

    private let limit = 10
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

    func fetch(filters: [Document.Filter], startAfter lastCashFlow: CashFlow? = nil) async throws -> ([CashFlow], QueryDocumentSnapshot?) {
        let docs = try await firestore.getDocuments(from: .cashFlows, orderedBy: [Order.name()], filteredBy: filters.map { $0.predicate }, startAfter: lastCashFlow, limit: limit)
        let cashFlows = docs.map { doc -> CashFlow in
            let categoryId = doc.getString(for: Field.categoryId)
            let category = storage.categories.first(where: { $0.id == categoryId })!
            return CashFlow(from: doc, category: category)
        }
        return (cashFlows, docs.last)
    }
}
