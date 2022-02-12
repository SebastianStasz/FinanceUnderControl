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
    var cashFlowSelection: CashFlowSelection = .all
    var cashFlowCategory: CashFlowCategoryEntity? = nil
    var datePickerViewData: DateRangePickerViewData = .init()
    var minimumValueInput = Input<NumberInputSettings>(settings: .init(canBeEmpty: true))
    var maximumValueInput = Input<NumberInputSettings>(settings: .init(canBeEmpty: true))

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
        if let minValue = minimumValueInput.value {
            predicates.append(Filter.minimumValue(minValue))
        }
        if let maxValue = maximumValueInput.value {
            predicates.append(Filter.maximumValue(maxValue))
        }
        return predicates.compactMap { $0 }.andNSPredicate
    }

    mutating func resetToDefaultValues() {
        cashFlowSelection = .all
        cashFlowCategory = nil
        datePickerViewData = .init()
        minimumValueInput.value = nil
        maximumValueInput.value = nil
    }
}

extension CashFlowFilter {
    typealias Filter = CashFlowEntity.Filter

    private var dateBetweenPredicate: Filter {
        .byDateBetween(startDate: datePickerViewData.startDate, endDate: datePickerViewData.endDate)
    }
}
