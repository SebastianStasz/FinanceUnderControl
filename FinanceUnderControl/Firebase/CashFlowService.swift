//
//  CashFlowService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import Foundation
import FirebaseFirestore

struct CashFlowService: CollectionService {
    typealias Document = CashFlow
    typealias Field = Document.Field

    private let firestore = FirestoreService.shared

    func create(model: CashFlow) async throws {
        try await firestore.createDocument(in: .cashFlows, data: model.data)
    }

    func fetchAll() async throws {
        let docs = try await firestore.getDocuments(from: .cashFlows, orderedBy: Field.date)
        print(docs)
    }
}
