//
//  FirestoreService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 02/05/2022.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

struct FirestoreService {
    static let shared = FirestoreService()

    private let db = Firestore.firestore()
    private let userId = Auth.auth().currentUser!.uid

    private init() {}

    private var userDocument: DocumentReference {
        db.collection(Collection.users.name).document(Collection.users.documentIdPrefix + userId)
    }

    func getDocument(fromReference reference: DocumentReference) async throws -> DocumentSnapshot {
        try await db.document(reference.path).getDocument()
    }

    func getDocuments<T: DocumentField>(from collection: Collection,
                                        lastDocument: QueryDocumentSnapshot? = nil,
                                        orderedBy orderField: OrderField<T>? = nil
    ) async throws -> [QueryDocumentSnapshot] {
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<[QueryDocumentSnapshot], Error>) in
            let query = userDocument.collection(collection.name)

//            if let orderField = orderField {
//                query = query.order(by: orderField.field.key, descending: orderField.order == .reverse) as! CollectionReference
//            }

            if let lastDocument = lastDocument {
                query.start(afterDocument: lastDocument)
            }

            query.getDocuments { snapShot, error in
                if let snapShot = snapShot {
                    continuation.resume(returning: snapShot.documents)
                } else if let error = error {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func createDocument(in collection: Collection, withId id: String, data: [String: Any]) async throws {
        try await userDocument
            .collection(collection.name)
            .document(collection.documentIdPrefix + id)
            .setData(data)
    }
}
