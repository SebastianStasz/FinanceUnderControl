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
    associatedtype Order: DocumentFieldOrder
    
    var data: [String: Any] { get }
}

protocol DocumentFieldOrder {

    var orderField: OrderField { get }
}
