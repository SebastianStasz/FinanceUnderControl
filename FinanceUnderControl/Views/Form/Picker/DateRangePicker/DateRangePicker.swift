//
//  DateRangePicker.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import SwiftUI
import Shared

struct DateRangePicker: View {

    @Binding private var viewData: DateRangePickerViewData
    private let title: String

    var body: some View {
        VStack {
            LabeledToggle(title, isOn: $viewData.isOn.animation(.easeOut))

            if viewData.isOn {
                VStack {
                    LabeledDatePicker(.cash_flow_filter_date_start, selection: $viewData.startDate, in: ...viewData.endDate)
                    LabeledDatePicker(.cash_flow_filter_date_end, selection: $viewData.endDate, in: viewData.startDate...)
                }
                .zIndex(-1)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .background(Color.backgroundSecondary)
        .cornerRadius(.base)
    }

    init(_ title: String, viewData: Binding<DateRangePickerViewData>) {
        self.title = title
        self._viewData = viewData
    }
}

// MARK: - Preview

struct DateRangePicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DateRangePicker("Date range picker", viewData: .constant(.init(isOn: true)))
            DateRangePicker("Date range picker", viewData: .constant(.init(isOn: true))).darkScheme()
        }
        .sizeThatFits()
    }
}
