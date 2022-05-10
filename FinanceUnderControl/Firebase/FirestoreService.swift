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

    func createDocument(in collection: Collection, withId id: String, data: [String: Any]) async throws {
        try await userDocument.collection(collection.name).document(collection.documentIdPrefix + id).setData(data)
    }

    func deleteDocument(withId documentId: String, from collection: Collection) async throws {
        try await userDocument.collection(collection.name).document(collection.documentIdPrefix + documentId).delete()
    }

    func getDocument(fromReference reference: DocumentReference) async throws -> DocumentSnapshot {
        try await db.document(reference.path).getDocument()
    }

    func getDocuments<T: DocumentField>(from collection: Collection, lastDocument: QueryDocumentSnapshot? = nil, orderedBy orderField: OrderField<T>? = nil) async throws -> [QueryDocumentSnapshot] {
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<[QueryDocumentSnapshot], Error>) in
            getQuery(for: collection, lastDocument: lastDocument, orderedBy: orderField)
                .getDocuments { snapShot, error in
                    if let snapShot = snapShot {
                        continuation.resume(returning: snapShot.documents)
                    } else if let error = error {
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func subscribe<T: DocumentField>(to collection: Collection, lastDocument: QueryDocumentSnapshot? = nil, orderedBy orderField: OrderField<T>? = nil) -> Subscription<[QueryDocumentSnapshot]> {
        let documentsSubject = PassthroughSubject<[QueryDocumentSnapshot], Never>()
        let errorsSubject = PassthroughSubject<Error, Never>()

        getQuery(for: collection, lastDocument: lastDocument, orderedBy: orderField)
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

    func getQuery<T: DocumentField>(for collection: Collection, lastDocument: QueryDocumentSnapshot? = nil, orderedBy orderField: OrderField<T>? = nil) -> CollectionReference {
        let query = userDocument.collection(collection.name)
        if let orderField = orderField {
            query.order(by: orderField.field.key, descending: orderField.order == .reverse)
        }
        if let lastDocument = lastDocument {
            query.start(afterDocument: lastDocument)
        }
        return query
    }
}
