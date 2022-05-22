//
//  QueryConfiguration.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 22/05/2022.
//

import Foundation

struct QueryConfiguration<Document: FirestoreDocument> {
    let filters: [Document.Filter]
    let sorters: [Document.Order]
    let limit: Int?

    init(filters: [Document.Filter] = [], sorters: [Document.Order] = [], limit: Int? = nil) {
        self.filters = filters
        self.sorters = sorters
        self.limit = limit
    }

    static var none: QueryConfiguration {
        .init(filters: [], sorters: [], limit: nil)
    }
}
