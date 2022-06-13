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
    private let storage = Database.shared.grouping
    private let categoryService = CashFlowCategoryService()
    private var lastDocument: QueryDocumentSnapshot?

    func createOrEdit(_ model: CashFlow) async throws {
        try await firestore.createOrEditDocument(withId: model.id, in: .cashFlows, data: model.data)
    }

    func delete(_ cashFlow: CashFlow) async throws {
        try await firestore.deleteDocument(withId: cashFlow.id, from: .cashFlows)
    }
}
