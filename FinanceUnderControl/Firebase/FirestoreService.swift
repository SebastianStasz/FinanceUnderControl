//
//  FirestoreService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import Combine
import FirebaseAuth
import FirebaseFirestore
import Foundation

struct FirestoreService {
    static let shared = FirestoreService()

    private let db = Firestore.firestore()
    private let userId = Auth.auth().currentUser!.uid

    private init() {}

    func createOrEditDocument(withId id: String, in collection: Collection, data: [String: Any]) async throws {
        try await documentReference(withId: id, in: collection).setData(data)
    }

    func createOrEditDocuments<T: FirestoreDocument>(_ documents: [T], in collection: Collection) async throws {
        let batch = db.batch()

        documents.forEach { doc in
            batch.setData(doc.data, forDocument: documentReference(withId: doc.id, in: collection))
        }
        try await batch.commit()
    }

    func deleteDocument(withId id: String, from collection: Collection) async throws {
        try await documentReference(withId: id, in: collection).delete()
    }

    func getDocument(fromReference reference: DocumentReference) async throws -> DocumentSnapshot {
        try await db.document(reference.path).getDocument()
    }

    func getDocuments<T, O: DocumentFieldOrder>(
        from collection: Collection,
        orderedBy orderFields: [O],
        filteredBy filters: [FirestoreServiceFilter] = [],
        startAfter document: T? = nil,
        limit: Int? = nil
    ) async throws -> [QueryDocumentSnapshot] where T == O.Document {
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<[QueryDocumentSnapshot], Error>) in
            getQuery(for: collection, orderedBy: orderFields, filteredBy: filters, startAfter: document, limit: limit)
                .getDocuments { snapShot, error in
                    if let snapShot = snapShot {
                        continuation.resume(returning: snapShot.documents)
                    } else if let error = error {
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func subscribe<T, O: DocumentFieldOrder>(
        to collection: Collection,
        orderedBy orderFields: [O],
        filteredBy filters: [FirestoreServiceFilter] = [],
        startAfter document: T? = nil,
        limit: Int? = nil
    ) -> FirestoreSubscription<[QueryDocumentSnapshot]> where T == O.Document {
        let documentsSubject = PassthroughSubject<[QueryDocumentSnapshot], Never>()
        let firstResultDocument = documentsSubject.map { $0.first }.asDriver
        let lastResultDocument = documentsSubject.map { $0.last }.asDriver
        let errorsSubject = PassthroughSubject<Error, Never>()

        getQuery(for: collection, orderedBy: orderFields, filteredBy: filters, startAfter: document, limit: limit)
            .addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    documentsSubject.send(querySnapshot.documents)
                } else if let error = error {
                    errorsSubject.send(error)
                }
            }
        return FirestoreSubscription(output: documentsSubject.eraseToAnyPublisher(), firstDocument: firstResultDocument, lastDocument: lastResultDocument, error: errorsSubject.eraseToAnyPublisher())
    }

    func getQuery<T, O: DocumentFieldOrder>(
        for collection: Collection,
        orderedBy orderFields: [O],
        filteredBy filters: [FirestoreServiceFilter] = [],
        startAfter document: T? = nil,
        limit: Int? = nil
    ) -> Query where T == O.Document {
        var query: Query = userDocument.collection(collection.name)

        filters.forEach {
            query = query.filter(by: $0)
        }

        orderFields.forEach {
            query = query.order(by: $0.orderField.field.key, descending: $0.orderField.order == .reverse)
        }
        query = query.order(by: "id")

        if let limit = limit {
            query = query.limit(to: limit)
        }
        if let document = document {
            var fieldValues = orderFields.map { $0.valueFrom(document) }
            fieldValues.append(document.id)
            query = query.start(after: fieldValues)
        }

        return query
    }
}

private extension FirestoreService {

    var userDocument: DocumentReference {
        db.collection(Collection.users.name).document(Collection.users.documentIdPrefix + userId)
    }

    func documentReference(withId id: String, in collection: Collection) -> DocumentReference {
        userDocument.collection(collection.name).document(collection.documentIdPrefix + id)
    }
}
