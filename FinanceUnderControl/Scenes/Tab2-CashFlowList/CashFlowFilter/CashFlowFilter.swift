//
//  CashFlowFilter.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 24/01/2022.
//

import FinanceCoreData
import Foundation
import SSValidation

struct CashFlowFilter: Equatable {
    var cashFlowSelection: CashFlowSelection = .all {
        didSet { cashFlowCategory = nil }
    }
    var cashFlowCategory: CashFlowCategoryEntity?
    var datePickerViewData: DateRangePickerViewData = .init()
    var minimumValue: Double?
    var maximumValue: Double?

    var nsPredicate: NSPredicate {
        var predicates: [Filter] = []

        if cashFlowSelection != .all, let type = cashFlowSelection.type {
            predicates.append(Filter.byType(type))
        }
        if datePickerViewData.isOn {
            predicates.append(dateBetweenPredicate)
        }
        if let cashFlowCategory = cashFlowCategory {
            predicates.append(Filter.byCategory(cashFlowCategory))
        }
        if let minValue = minimumValue {
            predicates.append(Filter.minimumValue(minValue))
        }
        if let maxValue = maximumValue {
            predicates.append(Filter.maximumValue(maxValue))
        }
        return predicates.compactMap { $0 }.andNSPredicate
    }

    mutating func resetToDefaultValues() {
        cashFlowSelection = .all
        cashFlowCategory = nil
        datePickerViewData = .init()
        minimumValue = nil
        maximumValue = nil
    }
}

extension CashFlowFilter {
    typealias Filter = CashFlowEntity.Filter

    private var dateBetweenPredicate: Filter {
        .byDateBetween(startDate: datePickerViewData.startDate, endDate: datePickerViewData.endDate)
    }
}
