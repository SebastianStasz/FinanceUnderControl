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
    ) -> FirestoreSubscription<[QueryDocumentSnapshot]> {
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
        return FirestoreSubscription(output: documentsSubject.eraseToAnyPublisher(), error: errorsSubject.eraseToAnyPublisher())
    }
}

private extension FirestoreService {

    var userDocument: DocumentReference {
        db.collection(Collection.users.name).document(Collection.users.documentIdPrefix + userId)
    }

    func documentReference(withId id: String, in collection: Collection) -> DocumentReference {
        userDocument.collection(collection.name).document(collection.documentIdPrefix + id)
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
