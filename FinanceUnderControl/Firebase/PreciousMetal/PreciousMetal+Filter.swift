//
//  PreciousMetal+Filter.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 26/06/2022.
//

import Foundation

extension PreciousMetal {

    enum Filter: DocumentFilter {

        var predicate: FirestoreServiceFilter {
            switch self {}
        }
    }
}
