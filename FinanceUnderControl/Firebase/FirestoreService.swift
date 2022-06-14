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

    var batch: WriteBatch {
        db.batch()
    }

    func createOrEditDocument(withId id: String, in collection: Collection, data: [String: Any]) async throws {
        try await documentReference(withId: id, in: collection).setData(data)
    }

    func edit(withId id: String, in collection: Collection, data: [String: Any], batch: WriteBatch) -> WriteBatch {
        let document = documentReference(withId: id, in: collection)
        return batch.updateData(data, forDocument: document)
    }

    func edit(withId id: String, in collection: Collection, data: [String: Any]) async throws {
        try await documentReference(withId: id, in: collection).updateData(data)
    }

    func create(withId id: String, in collection: Collection, data: [String: Any], batch: WriteBatch) -> WriteBatch {
        let document = documentReference(withId: id, in: collection)
        return batch.setData(data, forDocument: document)
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

    func deleteDocument(withId id: String, from collection: Collection, batch: WriteBatch) -> WriteBatch {
        let document = documentReference(withId: id, in: collection)
        return batch.deleteDocument(document)
    }

    func getDocument(fromReference reference: DocumentReference) async throws -> DocumentSnapshot {
        try await db.document(reference.path).getDocument()
    }

    func getDocuments<T: FirestoreDocument>(from collection: Collection, configuration: QueryConfiguration<T>) async throws -> [QueryDocumentSnapshot] where T == T.Order.Document {
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<[QueryDocumentSnapshot], Error>) in
            getQuery(for: collection, configuration: configuration)
                .getDocuments { snapShot, error in
                    if let snapShot = snapShot {
                        continuation.resume(returning: snapShot.documents)
                    } else if let error = error {
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func subscribe<T: FirestoreDocument>(to collection: Collection, configuration: QueryConfiguration<T>) -> FirestoreSubscription<[QueryDocumentSnapshot]> where T == T.Order.Document {
        let documentsSubject = PassthroughSubject<[QueryDocumentSnapshot], Never>()
        let firstResultDocument = documentsSubject.map { $0.first }.asDriver
        let lastResultDocument = documentsSubject.map { $0.last }.asDriver
        let errorsSubject = PassthroughSubject<Error, Never>()

        getQuery(for: collection, configuration: configuration)
            .addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    documentsSubject.send(querySnapshot.documents)
                } else if let error = error {
                    errorsSubject.send(error)
                }
            }
        return FirestoreSubscription(output: documentsSubject.eraseToAnyPublisher(), firstDocument: firstResultDocument, lastDocument: lastResultDocument, error: errorsSubject.eraseToAnyPublisher())
    }

    func getQuery<T: FirestoreDocument>(for collection: Collection, configuration: QueryConfiguration<T>) -> Query where T == T.Order.Document {
        var query: Query = userDocument.collection(collection.name)

        query = query.filter(by: configuration.filters)
        query = query.order(by: configuration.sorters)
        query = query.order(by: "id")

        if let limit = configuration.limit {
            query = query.limit(to: limit)
        }

        return query
    }

    func documentReference(withId id: String, in collection: Collection) -> DocumentReference {
        userDocument.collection(collection.name).document(collection.documentIdPrefix + id)
    }
}

private extension FirestoreService {

    var userDocument: DocumentReference {
        db.collection(Collection.users.name).document(Collection.users.documentIdPrefix + userId)
    }
}
