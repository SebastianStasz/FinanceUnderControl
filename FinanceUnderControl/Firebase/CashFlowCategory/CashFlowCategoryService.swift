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
