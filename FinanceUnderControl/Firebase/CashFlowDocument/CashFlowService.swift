//
//  CashFlowService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

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
        try await firestore.createDocument(in: .cashFlows, data: model.data)
    }

    func fetch() async throws -> [CashFlow] {
        let docs = try await firestore.getDocuments(from: .cashFlows, lastDocument: lastDocument, orderedBy: OrderField(field: Field.date, order: .reverse))
        lastDocument = docs.last
        return try await docs.asyncMap {
            if storage.cashFlowCategories.isEmpty {
                try await storage.updateCashFlowCategories()
            }
            let categoryId = $0.getString(for: Field.categoryId)

            guard let category = storage.cashFlowCategories.first(where: { $0.id == categoryId }) else {
                return nil
            }
            return CashFlow(from: $0, category: category)
        }
        .compactMap { $0 }
    }
}

protocol StorageProtocol {
    var cashFlowCategories: [CashFlowCategory] { get }
}

final class Storage: StorageProtocol {
    static let shared = Storage()

    private lazy var cashFlowCategoryService = CashFlowCategoryService()

    private(set) var cashFlowCategories: [CashFlowCategory] = []

    var incomeCashFlowCategories: [CashFlowCategory] {
        cashFlowCategories.filter { $0.type == .income }
    }

    var expenseCashFlowCategories: [CashFlowCategory] {
        cashFlowCategories.filter { $0.type == .expense }
    }

    func updateCashFlowCategories() async throws {
        try await cashFlowCategories = cashFlowCategoryService.getAll()
    }
}
