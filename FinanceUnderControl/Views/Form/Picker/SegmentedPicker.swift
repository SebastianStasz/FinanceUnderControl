//
//  SegmentedPicker.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 17/01/2022.
//

import SwiftUI

struct SegmentedPicker<T: Pickerable>: View {

    @Binding private var selection: T
    private let title: String
    private let elements: [T]

    var body: some View {
        Picker(title, selection: $selection.animation(.easeInOut(duration: 0.3))) {
            ForEach(elements) {
                Text($0.valueName).tag($0)
            }
        }
        .pickerStyle(.segmented)
    }

    init(_ title: String, selection: Binding<T>, elements: [T]) {
        self.title = title
        self._selection = selection
        self.elements = elements
    }
}


// MARK: - Preview

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        let elements = ["Value 1", "Value 2", "Value 3"]
        SegmentedPicker("Picker", selection: .constant("Value 1"), elements: elements)
    }
}
