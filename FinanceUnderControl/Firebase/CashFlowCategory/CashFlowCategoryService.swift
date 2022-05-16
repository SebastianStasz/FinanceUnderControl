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

    func createOrEdit(_ model: CashFlowCategory) async throws {
        try await firestore.createOrEditDocument(withId: model.id, in: .cashFlowCategories, data: model.data)
    }

    func createOrEdit(_ models: [CashFlowCategory]) async throws {
        try await firestore.createOrEditDocuments(models, in: .cashFlowCategories)
    }

    func delete(_ category: CashFlowCategory) async throws {
        try await firestore.deleteDocument(withId: category.id, from: .cashFlowCategories)
    }
}
