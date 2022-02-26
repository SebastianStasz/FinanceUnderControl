//
//  CashFlowFilterView+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import SSUtils
import Shared

extension CashFlowFilterView {

    var cashFlowTypeSector: some View {
        Sector(.cash_flow_filter_type) {
            SegmentedPicker(.cash_flow_filter_type, selection: filter.cashFlowSelection, elements: CashFlowSelection.allCases)
            LabeledPicker(.common_category, elements: cashFlowCategories, selection: filter.cashFlowCategory)
                .displayIf(filter.wrappedValue.cashFlowSelection != .all, withTransition: .scale)
        }
    }

    var amountSector: some View {
        Sector(.common_amount) {
            LabeledInputNumber(.cash_flow_filter_minimum_value, input: filter.minimumValueInput, prompt: .common_none)
            LabeledInputNumber(.cash_flow_filter_maximum_value, input: filter.maximumValueInput, prompt: .common_none)
        }
    }

    var otherSector: some View {
        Sector("Other") {
            DateRangePicker(.cash_flow_filter_date_range, viewData: filter.datePickerViewData)
        }
    }
}
