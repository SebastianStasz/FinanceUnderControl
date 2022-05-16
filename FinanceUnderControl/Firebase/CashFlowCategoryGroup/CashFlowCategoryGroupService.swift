//
//  CashFlowCategoryGroupService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation

final class CashFlowCategoryGroupService: CollectionService {
    typealias Document = CashFlowCategoryGroup

    private let firestore = FirestoreService.shared

    func createOrEdit(_ model: CashFlowCategoryGroup) async throws {
        try await firestore.createOrEditDocument(withId: model.id, in: .cashFlowCategoryGroups, data: model.data)
    }

    func delete(_ group: CashFlowCategoryGroup) async throws {
        try await firestore.deleteDocument(withId: group.id, from: .cashFlowCategoryGroups)
    }

    func getAll() async throws -> [CashFlowCategoryGroup] {
        try await firestore.getDocuments(from: .cashFlowCategoryGroups, orderedBy: Order.name())
            .map { CashFlowCategoryGroup(from: $0) }
    }
}
