//
//  PickerDSView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

struct PickerDSView: View {

    @State private var labeledPickerSelection: PickerDSType? = .firstOption
    @State private var segmentedPickerSelection: PickerDSType = .firstOption
    @State private var dateRangePickerViewData = MonthAndYearPickerVD()

    var body: some View {
        Group {
            LabeledPicker("Title", elements: PickerDSType.allCases, selection: $labeledPickerSelection)
                .designSystemComponent("Labeled Picker")

            SegmentedPicker("Title", selection: $segmentedPickerSelection, elements: PickerDSType.allCases)
                .designSystemComponent("Segmented Picker")

            MonthAndYearPicker("Title", viewData: $dateRangePickerViewData)
                .designSystemComponent("Date Range Picker")
        }
        .designSystemView("Picker")
    }
}

// MARK: - Preview

struct PickerDSView_Previews: PreviewProvider {
    static var previews: some View {
        PickerDSView()
        PickerDSView().darkScheme()
    }
}

private enum PickerDSType: String, Pickerable, CaseIterable {
    case firstOption
    case secondOption
    case thirdOption

    var valueName: String { rawValue }
}
