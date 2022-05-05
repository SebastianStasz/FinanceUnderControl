//
//  FirestoreDocument.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 04/05/2022.
//

import FirebaseFirestore
import Foundation

protocol FirestoreDocument {
    associatedtype Field: DocumentField
    
    var data: [String: Any] { get }

    init(from queryDocumentSnapshot: QueryDocumentSnapshot)
}
