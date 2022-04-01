//
//  PickerDSView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import Shared
import SwiftUI

struct PickerDSView: View {

    @State private var labeledPickerSelection: CashFlowSelection? = .all
    @State private var segmentedPickerSelection: CashFlowSelection = .all
    @State private var dateRangePickerViewData = DateRangePickerViewData()

    var body: some View {
        Group {
            LabeledPicker("Title", elements: CashFlowSelection.allCases, selection: $labeledPickerSelection)
                .designSystemComponent("Labeled Picker")

            SegmentedPicker("Title", selection: $segmentedPickerSelection, elements: CashFlowSelection.allCases)
                .designSystemComponent("Segmented Picker")

            DateRangePicker("Title", viewData: $dateRangePickerViewData)
                .designSystemComponent("Date Range Picker")
        }
        .designSystemView("Picker")
    }
}

// MARK: - Preview

struct PickerDSView_Previews: PreviewProvider {
    static var previews: some View {
        PickerDSView().embedInNavigationView()
    }
}
