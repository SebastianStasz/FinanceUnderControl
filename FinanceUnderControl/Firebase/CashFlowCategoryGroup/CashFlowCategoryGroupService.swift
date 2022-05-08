//
//  CashFlowCategoryGroupService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation

final class CashFlowCategoryGroupService: CollectionService {
    typealias Document = CashFlowCategoryGroup
    typealias Field = Document.Field

    private let firestore = FirestoreService.shared
    private let categoryService = CashFlowCategoryService()

    func getAll() async throws -> [CashFlowCategoryGroup] {
        try await firestore.getDocuments(from: .cashFlowCategoryGroups, orderedBy: orderField)
            .map { CashFlowCategoryGroup(from: $0) }
    }

    private var orderField: OrderField<Field> {
        OrderField(field: Field.name)
    }
}
