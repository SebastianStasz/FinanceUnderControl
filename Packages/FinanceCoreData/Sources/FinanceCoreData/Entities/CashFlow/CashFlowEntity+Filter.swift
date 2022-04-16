//
//  CashFlowEntity+Filter.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation
import Shared

public extension CashFlowEntity {

    enum Filter: EntityFilter {
        case nameContains(String)
        case type(CashFlowType)
        case category(CashFlowCategoryEntity)
        case dateBetween(startDate: Date, endDate: Date)
        case minimumValue(Double)
        case maximumValue(Double)
        case currencyIs(CurrencyEntity)
        case monthAndYear(from: Date)

        public var nsPredicate: NSPredicate {
            switch self {
            case let .nameContains(text):
                return predicateForNameContains(text)
            case let .type(type):
                return predicateForCategoryType(type)
            case let .category(category):
                return predicateForCategory(category)
            case let .dateBetween(startDate: startDate, endDate: endDate):
                return predicateForDateBetween(startDate, and: endDate)
            case let .minimumValue(value):
                return predicateForMinimumValue(value)
            case let .maximumValue(value):
                return predicateForMaximumValue(value)
            case let .currencyIs(currency):
                return predicateForCurrency(currency)
            case let .monthAndYear(date):
                return predicateForMonthAndYear(date)
            }
        }
    }
}

// MARK: - Predicates

private extension CashFlowEntity {
    static func predicateForNameContains(_ text: String) -> NSPredicate {
        NSPredicate(format: "name CONTAINS[cd] %@", text)
    }

    static func predicateForCategoryType(_ type: CashFlowType) -> NSPredicate {
        NSPredicate(format: "category.type_ == %@", type.rawValue)
    }

    static func predicateForCategory(_ category: CashFlowCategoryEntity) -> NSPredicate {
        NSPredicate(format: "category == %@", category)
    }

    static func predicateForDateBetween(_ startDate: Date, and endDate: Date) -> NSPredicate {
        let startDatePredicate = NSPredicate(format: "date >= %@", startDate as CVarArg)
        let endDatePredicate = NSPredicate(format: "date <= %@", endDate as CVarArg)
        return NSCompoundPredicate(type: .and, subpredicates: [startDatePredicate, endDatePredicate])
    }

    static func predicateForMinimumValue(_ value: Double) -> NSPredicate {
        NSPredicate(format: "value_ >= %f", value)
    }

    static func predicateForMaximumValue(_ value: Double) -> NSPredicate {
        NSPredicate(format: "value_ <= %f", value)
    }

    static func predicateForCurrency(_ currency: CurrencyEntity) -> NSPredicate {
        NSPredicate(format: "currency_ == %@", currency)
    }

    static func predicateForMonthAndYear(_ date: Date) -> NSPredicate {
        NSPredicate(format: "monthAndYear == %@", date.monthAndYear as CVarArg)
    }
}
