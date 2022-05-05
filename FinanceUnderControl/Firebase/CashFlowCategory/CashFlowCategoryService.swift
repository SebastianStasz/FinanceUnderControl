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
    typealias Field = Document.Field

    private let firestore = FirestoreService.shared

    func getAll() async throws -> [CashFlowCategory] {
        try await firestore.getDocuments(from: .cashFlowCategories, orderedBy: orderField)
            .map { CashFlowCategory(from: $0) }
    }

    private var orderField: OrderField<Field> {
        OrderField(field: Field.name)
    }
}
