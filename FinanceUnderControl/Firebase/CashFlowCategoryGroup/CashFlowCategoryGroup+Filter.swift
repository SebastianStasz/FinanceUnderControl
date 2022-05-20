//
//  CashFlowCategoryGroup+Filter.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 20/05/2022.
//

import Foundation
import Shared

extension CashFlowCategoryGroup {

    enum Filter: DocumentFilter {
        case isType(CashFlowType)

        var predicate: FirestoreServiceFilter {
            switch self {
            case let .isType(type):
                return .isEqual(field: Field.type.key, value: type.rawValue)
            }
        }
    }
}
