//
//  CashFlowService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import Foundation
import FirebaseFirestore

final class CashFlowService: CollectionService {
    typealias Document = CashFlowDocument
    typealias Field = Document.Field

    private let firestore = FirestoreService.shared
    private var lastDocument: QueryDocumentSnapshot?

    func create(model: CashFlowDocument) async throws {
        try await firestore.createDocument(in: .cashFlows, data: model.data)
    }

    func fetch() async throws -> [CashFlowDocument] {
        let docs = try await firestore.getDocuments(from: .cashFlows, lastDocument: lastDocument, orderedBy: OrderField(field: Field.date, order: .reverse))
        lastDocument = docs.last
        return docs.map { CashFlowDocument(from: $0) }
    }
}
