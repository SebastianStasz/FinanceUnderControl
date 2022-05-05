//
//  CollectionService.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 04/05/2022.
//

import Foundation

protocol CollectionService {
    associatedtype Document: FirestoreDocument
    associatedtype Field: DocumentField
}
