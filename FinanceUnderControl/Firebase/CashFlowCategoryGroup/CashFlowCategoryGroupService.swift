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

    func create(_ group: CashFlowCategoryGroup) async throws {
        try await firestore.createDocument(in: .cashFlowCategoryGroups, withId: group.id, data: group.data)
    }

    func getAll() async throws -> [CashFlowCategoryGroup] {
        try await firestore.getDocuments(from: .cashFlowCategoryGroups, orderedBy: Order.name())
            .map { CashFlowCategoryGroup(from: $0) }
    }
}
