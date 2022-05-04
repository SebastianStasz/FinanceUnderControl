//
//  CashFlowService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import Foundation

struct CashFlowService: CollectionService {
    typealias Field = CashFlow.Field

    private let firestore = FirestoreService.shared

    func create(model: CashFlow) async throws {
        try await firestore.createDocument(in: .cashFlows, data: model.data)
    }

    func fetchAll() async throws {
        let docs = try await firestore.getDocuments(from: .cashFlows, orderedBy: Field.date)
        print(docs)
    }
}
