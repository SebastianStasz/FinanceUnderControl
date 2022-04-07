//
//  CashFlowEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation

public extension CashFlowEntity {

    enum Filter: EntityFilter {
        case nameContains(String)
        case byType(CashFlowType)
        case byCategory(CashFlowCategoryEntity)
        case byDateBetween(startDate: Date, endDate: Date)
        case minimumValue(Double)
        case maximumValue(Double)
        case currencyIs(CurrencyEntity)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .nameContains(text):
                return predicateForNameContains(text)
            case let .byType(type):
                return predicateForCategoryType(type)
            case let .byCategory(category):
                return predicateForCategory(category)
            case let .byDateBetween(startDate: startDate, endDate: endDate):
                return predicateForDateBetween(startDate, and: endDate)
            case let .minimumValue(value):
                return predicateForMinimumValue(value)
            case let .maximumValue(value):
                return predicateForMaximumValue(value)
            case let .currencyIs(currency):
                return predicateForCurrency(currency)
            }
        }
    }
}

// MARK: - Predicates

extension CashFlowEntity {
    static private func predicateForNameContains(_ text: String) -> NSPredicate {
        NSPredicate(format: "name CONTAINS[cd] %@", text)
    }

    static private func predicateForCategoryType(_ type: CashFlowType) -> NSPredicate {
        NSPredicate(format: "category.type_ == %@", type.rawValue)
    }

    static private func predicateForCategory(_ category: CashFlowCategoryEntity) -> NSPredicate {
        NSPredicate(format: "category == %@", category)
    }

    static private func predicateForDateBetween(_ startDate: Date, and endDate: Date) -> NSPredicate {
        let startDatePredicate = NSPredicate(format: "date >= %@", startDate as CVarArg)
        let endDatePredicate = NSPredicate(format: "date <= %@", endDate as CVarArg)
        return NSCompoundPredicate(type: .and, subpredicates: [startDatePredicate, endDatePredicate])
    }

    static private func predicateForMinimumValue(_ value: Double) -> NSPredicate {
        NSPredicate(format: "value >= %f", value)
    }

    static private func predicateForMaximumValue(_ value: Double) -> NSPredicate {
        NSPredicate(format: "value <= %f", value)
    }

    static private func predicateForCurrency(_ currency: CurrencyEntity) -> NSPredicate {
        NSPredicate(format: "currency == %@", currency)
    }
}
