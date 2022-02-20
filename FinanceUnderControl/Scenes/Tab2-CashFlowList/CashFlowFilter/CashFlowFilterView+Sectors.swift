//
//  CashFlowFilterView+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import SSUtils

extension CashFlowFilterView {

    var cashFlowTypeSector: some View {
        Sector("Cash flow type") {
            SegmentedPicker("Cash flow type", selection: filter.cashFlowSelection, elements: CashFlowSelection.allCases)
            LabeledPicker("Category", elements: cashFlowCategories, selection: filter.cashFlowCategory)
                .displayIf(filter.wrappedValue.cashFlowSelection != .all, withTransition: .scale)
        }
    }

    var amountSector: some View {
        Sector("Amount") {
            LabeledInputNumber("Minimum value", input: filter.minimumValueInput, prompt: "None")
            LabeledInputNumber("Maximum value", input: filter.maximumValueInput, prompt: "None")
        }
    }

    var otherSector: some View {
        Sector("Other") {
            DateRangePicker("Date", viewData: filter.datePickerViewData)
        }
    }
}
