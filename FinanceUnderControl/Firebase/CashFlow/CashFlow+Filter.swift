//
//  CashFlow+Filter.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 10/05/2022.
//

import Foundation
import Shared

extension CashFlow {

    enum Filter: DocumentFilter {
        case nameContains(String)
        case isType(CashFlowType)
        case isCategory(CashFlowCategory)
        case isCurrency(Currency)
        case isDate(year: Int, month: Int)

        var predicate: FirestoreServiceFilter {
            switch self {
            case let .nameContains(text):
                return .contains(field: Field.nameLowercase.key, value: text.lowerCaseDiacriticInsensitive)
            case let .isType(type):
                return .isEqual(field: Field.type.key, value: type.rawValue)
            case let .isCategory(category):
                return .isEqual(field: Field.categoryId.key, value: category.id)
            case let .isCurrency(currency):
                return .isEqual(field: Field.currency.key, value: currency.code)
            case let .isDate(year, month):
                return .areEqual(fields: [Field.year.key, Field.month.key], values: [year, month])
            }
        }
    }
}
