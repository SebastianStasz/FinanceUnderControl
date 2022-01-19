//
//  CashFlowFilterView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import SwiftUI
import Shared

struct CashFlowFilter {
    var cashFlowType: CashFlowSelection = .all
    var datePickerViewData: DateRangePickerViewData = .init()
}

struct CashFlowFilterView: View {

    @Binding var cashFlowFilter: CashFlowFilter

    var body: some View {
        VStack(spacing: .huge) {
            VStack(alignment: .leading, spacing: .small) {
                Text("Cash flow type")
                SegmentedPicker("Cash flow type", selection: $cashFlowFilter.cashFlowType, elements: CashFlowSelection.allCases)
            }

            DateRangePicker("Date", viewData: $cashFlowFilter.datePickerViewData)

            Spacer()
        }
        .padding(.horizontal, .medium)
        .padding(.vertical, .big)
        .background(Color.backgroundPrimary)
        .asSheet(title: "Filter")
    }
}


// MARK: - Preview

struct CashFlowFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowFilterView(cashFlowFilter: .constant(.init()))
    }
}
