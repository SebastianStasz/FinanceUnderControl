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

    func createOrEditDocument(in collection: Collection, withId id: String, data: [String: Any]) async throws {
        try await userDocument.collection(collection.name).document(collection.documentIdPrefix + id).setData(data)
    }

    func deleteDocument(withId documentId: String, from collection: Collection) async throws {
        try await userDocument.collection(collection.name).document(collection.documentIdPrefix + documentId).delete()
    }

    func getDocument(fromReference reference: DocumentReference) async throws -> DocumentSnapshot {
        try await db.document(reference.path).getDocument()
    }

    func getDocuments<T: DocumentFieldOrder>(
        from collection: Collection,
        orderedBy orderField: T,
        filteredBy filters: [FirestoreServiceFilter] = [],
        lastDocument: QueryDocumentSnapshot? = nil
    ) async throws -> [QueryDocumentSnapshot] {
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<[QueryDocumentSnapshot], Error>) in
            getQuery(for: collection, orderedBy: orderField, filteredBy: filters, lastDocument: lastDocument)
                .getDocuments { snapShot, error in
                    if let snapShot = snapShot {
                        continuation.resume(returning: snapShot.documents)
                    } else if let error = error {
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func subscribe<T: DocumentFieldOrder>(
        to collection: Collection,
        orderedBy orderField: T,
        filteredBy filters: [FirestoreServiceFilter] = [],
        lastDocument: QueryDocumentSnapshot? = nil
    ) -> Subscription<[QueryDocumentSnapshot]> {
        let documentsSubject = PassthroughSubject<[QueryDocumentSnapshot], Never>()
        let errorsSubject = PassthroughSubject<Error, Never>()

        getQuery(for: collection, orderedBy: orderField, filteredBy: filters, lastDocument: lastDocument)
            .addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    documentsSubject.send(querySnapshot.documents)
                } else if let error = error {
                    errorsSubject.send(error)
                }
            }
        return Subscription(output: documentsSubject.eraseToAnyPublisher(), error: errorsSubject.eraseToAnyPublisher())
    }

}

private extension FirestoreService {

    var userDocument: DocumentReference {
        db.collection(Collection.users.name).document(Collection.users.documentIdPrefix + userId)
    }

    func getQuery(
        for collection: Collection,
        orderedBy order: DocumentFieldOrder,
        filteredBy filters: [FirestoreServiceFilter],
        lastDocument: QueryDocumentSnapshot?
    ) -> Query {
        var query = userDocument.collection(collection.name)
            .order(by: order.orderField.name, descending: order.orderField.order == .reverse)

        filters.forEach {
            query = query.filter(by: $0)
        }

        if let lastDocument = lastDocument {
            query = query.start(afterDocument: lastDocument)
        }

        return query
    }
}
