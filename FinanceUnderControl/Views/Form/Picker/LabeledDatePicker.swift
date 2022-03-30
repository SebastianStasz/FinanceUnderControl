//
//  LabeledDatePicker.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/03/2022.
//

import Shared
import SSUtils
import SwiftUI

struct LabeledDatePicker: View {

    private let title: String
    private let components: DatePicker<Text>.Components
    private let partialRangeFrom: PartialRangeFrom<Date>?
    private let partialRangeThrough: PartialRangeThrough<Date>?
    @Binding private var selectedDate: Date

    private init(
        _ title: String,
        selection selectedDate: Binding<Date>,
        components: DatePicker<Text>.Components = .date,
        partialRangeFrom: PartialRangeFrom<Date>? = nil,
        partialRangeThrough: PartialRangeThrough<Date>? = nil
    ) {
        self.title = title
        self._selectedDate = selectedDate
        self.components = components
        self.partialRangeFrom = partialRangeFrom
        self.partialRangeThrough = partialRangeThrough
    }

    var body: some View {
        LabeledView("\(title):") {
            Text(selectedDate.string(format: .medium), style: .headlineSmallAction)
                .overlay(datePicker)
        }
    }

    private var datePicker: some View {
        Group {
            if let dateRange = partialRangeThrough {
                DatePicker(title, selection: $selectedDate, in: dateRange, displayedComponents: components)
            } else if let dateRange = partialRangeFrom {
                DatePicker(title, selection: $selectedDate, in: dateRange, displayedComponents: components)
            } else {
                DatePicker(title, selection: $selectedDate, displayedComponents: components)
            }
        }
        .labelsHidden()
        .colorMultiply(.clear)
    }
}

// MARK: - Preview

struct LabeledDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LabeledDatePicker("Picker title", selection: .constant(.now))
            LabeledDatePicker("Picker title", selection: .constant(.now)).darkScheme()
        }
        .sizeThatFits()
    }
}

// MARK: - Initializers

extension LabeledDatePicker {

    init(_ title: String,
         selection: Binding<Date>,
         components: DatePicker<Text>.Components = .date
    ) {
        self.init(title, selection: selection, components: components, partialRangeFrom: nil, partialRangeThrough: nil)
    }

    init(_ title: String,
         selection: Binding<Date>,
         components: DatePicker<Text>.Components = .date,
         in dateRange: PartialRangeFrom<Date>
    ) {
        self.init(title, selection: selection, components: components, partialRangeFrom: dateRange)
    }

    init(_ title: String,
         selection: Binding<Date>,
         components: DatePicker<Text>.Components = .date,
         in dateRange: PartialRangeThrough<Date>
    ) {
        self.init(title, selection: selection, components: components, partialRangeThrough: dateRange)
    }
}
