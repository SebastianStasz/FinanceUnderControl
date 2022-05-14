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
        try await firestore.createOrEditDocument(in: .cashFlowCategoryGroups, withId: model.id, data: model.data)
    }

    func getAll() async throws -> [CashFlowCategoryGroup] {
        try await firestore.getDocuments(from: .cashFlowCategoryGroups, orderedBy: Order.name())
            .map { CashFlowCategoryGroup(from: $0) }
    }
}
