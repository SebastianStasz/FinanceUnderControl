//
//  CashFlowFilter.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 24/01/2022.
//

import Foundation
import Shared
import SSValidation

struct CashFlowFilter: Equatable {
    var minimumValue: Double?
    var maximumValue: Double?
    var currency: Currency?
    var cashFlowCategory: CashFlowCategory?
    var datePickerViewData: DateRangePickerViewData = .init()
    var cashFlowSelection: CashFlowSelection = .all {
        didSet { cashFlowCategory = nil }
    }

    var isFiltering: Bool {
        minimumValue != nil || maximumValue != nil || currency != nil || cashFlowCategory != nil || datePickerViewData.isOn || cashFlowSelection != .all
    }

    var firestoreFilters: [CashFlow.Filter] {
        var filters: [CashFlow.Filter] = []
        if let cashFlowType = cashFlowSelection.type {
            filters.append(.isType(cashFlowType))
        }
        if let cashFlowCategory = cashFlowCategory {
            filters.append(.isCategory(cashFlowCategory))
        }
        if let currency = currency {
            filters.append(.isCurrency(currency))
        }
        return filters
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
