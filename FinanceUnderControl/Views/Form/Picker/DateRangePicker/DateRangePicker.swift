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
        VStack(spacing: .micro) {
            LabeledToggle(title, isOn: $viewData.isOn.animation(.easeOut))

            if viewData.isOn {
                VStack(spacing: .micro) {
                    DatePicker("Start date", selection: $viewData.startDate, in: ...viewData.endDate, displayedComponents: .date)
                    DatePicker("End date", selection: $viewData.endDate, in: viewData.startDate..., displayedComponents: .date)
                }
                .zIndex(-1)
                .padding(.horizontal, .small)
                .padding(.bottom, .small)
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
        DateRangePicker("Date range picker", viewData: .constant(.init(isOn: true)))
            .asPreview()
    }
}