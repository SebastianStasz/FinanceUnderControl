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

    mutating func resetToDefaultValues() {
        cashFlowSelection = .all
        cashFlowCategory = nil
        datePickerViewData = .init()
        minimumValue = nil
        maximumValue = nil
        currency = nil
    }
}
