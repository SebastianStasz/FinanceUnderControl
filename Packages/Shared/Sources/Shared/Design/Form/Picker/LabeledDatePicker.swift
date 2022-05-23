//
//  LabeledDatePicker.swift
//  Shared
//
//  Created by sebastianstaszczyk on 28/03/2022.
//

import SSUtils
import SwiftUI

public struct LabeledDatePicker: View {

    private let title: String
    private let components: DatePicker<Text>.Components
    @Binding private var selectedDate: Date

    public init(
        _ title: String,
        selection selectedDate: Binding<Date>,
        components: DatePicker<Text>.Components = .date
    ) {
        self.title = title
        self._selectedDate = selectedDate
        self.components = components
    }

    public var body: some View {
        LabeledView("\(title):") {
            Text(selectedDate.string(format: .medium), style: .body(.action))
                .overlay(datePicker)
        }
    }

    private var datePicker: some View {
        DatePicker(title, selection: $selectedDate, displayedComponents: components)
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
