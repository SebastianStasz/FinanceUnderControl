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

    func createDocument(in collection: Collection, data: [String: Any]) async throws {
        var data = data
        data["userId"] = userId
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<Void, Error>) in
            db.collection(collection.rawValue).addDocument(data: data) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}
