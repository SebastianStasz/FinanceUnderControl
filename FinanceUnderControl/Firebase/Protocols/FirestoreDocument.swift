//
//  FirestoreDocument.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 04/05/2022.
//

import FirebaseFirestore
import Foundation

protocol FirestoreDocument: Identifiable, Equatable {
    associatedtype Field: DocumentField
    associatedtype Order: DocumentOrder
    associatedtype Filter: DocumentFilter

    var id: String { get }
    var data: [String: Any] { get }
}

protocol DocumentOrder {
    associatedtype Document: FirestoreDocument
    var orderField: OrderField<Document> { get }
    func valueFrom(_ document: Document) -> Any
}

extension DocumentOrder {
    func valueFrom(_ document: Document) -> Any {
        orderField.valueFrom(document)
    }
}

protocol DocumentFilter {
    var predicate: FirestoreServiceFilter { get }
}
