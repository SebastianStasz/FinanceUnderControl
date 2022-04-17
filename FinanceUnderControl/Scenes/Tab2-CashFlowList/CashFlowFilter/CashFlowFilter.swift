//
//  CashFlowFilter.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 24/01/2022.
//

import FinanceCoreData
import Foundation
import Shared
import SSValidation

struct CashFlowFilter: Equatable {
//    private(set) var filterCount = 0

    var minimumValue: Double?
    var maximumValue: Double?
    var currency: CurrencyEntity?
    var cashFlowCategory: CashFlowCategoryEntity?
    var datePickerViewData: DateRangePickerViewData = .init()
    var cashFlowSelection: CashFlowSelection = .all {
        didSet { cashFlowCategory = nil }
    }

    var filterCount: Int {
        var count = [minimumValue, maximumValue].map { $0.isNil ? 0 : 1 }.reduce(0, +)
        count += currency.isNil ? 0 : 1
        count += cashFlowCategory.isNil ? 0 : 1
        count += datePickerViewData.isOn ? 1 : 0
        count += cashFlowSelection != .all ? 1 : 0
        return count
    }

    var nsPredicate: NSPredicate? {
        var predicates: [Filter] = []

        if cashFlowSelection != .all, let type = cashFlowSelection.type {
            predicates.append(Filter.type(type))
        }
        if datePickerViewData.isOn {
            predicates.append(dateBetweenPredicate)
        }
        if let cashFlowCategory = cashFlowCategory {
            predicates.append(Filter.category(cashFlowCategory))
        }
        if let minValue = minimumValue {
            predicates.append(Filter.minimumValue(minValue))
        }
        if let maxValue = maximumValue {
            predicates.append(Filter.maximumValue(maxValue))
        }
        if let currency = currency {
            predicates.append(Filter.currencyIs(currency))
        }
        return predicates.compactMap { $0 }.andNSPredicate
    }

    mutating func resetToDefaultValues() {
        cashFlowSelection = .all
        cashFlowCategory = nil
        datePickerViewData = .init()
        minimumValue = nil
        maximumValue = nil
        currency = nil
    }
}

extension CashFlowFilter {
    typealias Filter = CashFlowEntity.Filter

    private var dateBetweenPredicate: Filter {
        .dateBetween(startDate: datePickerViewData.startDate, endDate: datePickerViewData.endDate)
    }
}
