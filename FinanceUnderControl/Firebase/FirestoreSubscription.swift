//
//  FirestoreSubscription.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/05/2022.
//

import Combine
import FirebaseFirestore
import Foundation

struct FirestoreSubscription<T> {
    let output: AnyPublisher<T, Never>
    let firstDocument: AnyPublisher<QueryDocumentSnapshot?, Never>
    let lastDocument: AnyPublisher<QueryDocumentSnapshot?, Never>
    let error: AnyPublisher<Error, Never>
}

struct FirestoreBatch {
    let id: String
    let data: [String: Any]
}
