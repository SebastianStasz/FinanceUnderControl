//
//  FirestoreDocument.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 04/05/2022.
//

import Foundation

protocol FirestoreDocument {
    associatedtype Field: DocumentField
    
    var data: [String: Any] { get }
}
