//
//  MonthAndYearPicker.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import SwiftUI
import SSUtils

public struct MonthAndYearPicker: View {

    @Binding private var viewData: MonthAndYearPickerVD
    private let title: String

    public init(_ title: String, viewData: Binding<MonthAndYearPickerVD>) {
        self.title = title
        self._viewData = viewData
    }

    public var body: some View {
        VStack {
            LabeledToggle(title, isOn: $viewData.isOn.animation(.easeOut))

            if viewData.isOn {
                HStack(alignment: .center) {
                    Picker("Year", selection: $viewData.year) {
                        ForEach(viewData.yearRange, id: \.self) { Text($0.asString).tag($0) }
                    }
                    .frame(width: pickerWidth, height: 100)
                    .clipped()
                    .padding(.leading, .large)

                    Picker("Month", selection: $viewData.month) {
                        ForEach(1...12, id: \.self) { Text(Calendar.current.shortMonthSymbols[$0-1]).tag($0) }
                    }
                    .frame(width: pickerWidth, height: 100)
                    .clipped()
                }
                .zIndex(-1)
                .pickerStyle(.wheel)
                .padding(.top, -4)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .background(Color.backgroundSecondary)
        .cornerRadius(.base)
    }

    private var pickerWidth: CGFloat {
        UIScreen.screenWidth / 2 - 2 * .large
    }
}

extension UIPickerView {
  open override var intrinsicContentSize: CGSize {
      return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
  }
}

// MARK: - Preview

struct DateRangePicker_Previews: PreviewProvider {
    static var previews: some View {
        var viewData = MonthAndYearPickerVD()
        viewData.isOn = false
        return Group {
            MonthAndYearPicker("Date", viewData: .constant(viewData))
            MonthAndYearPicker("Date", viewData: .constant(viewData)).darkScheme()
        }
        .sizeThatFits()
    }
}
