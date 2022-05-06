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
        let allCategories = try await categoryService.getAll()
        return try await firestore.getDocuments(from: .cashFlowCategoryGroups, orderedBy: orderField)
            .map { doc -> CashFlowCategoryGroup in
                let categoryIds = doc.getStringArray(for: Field.categories)
                let categories = allCategories.filter { categoryIds.contains($0.id) }
                return CashFlowCategoryGroup(from: doc, categories: categories)
            }
    }

    private var orderField: OrderField<Field> {
        OrderField(field: Field.name)
    }
}
