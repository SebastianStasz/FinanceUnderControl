//
//  SegmentedPicker.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 17/01/2022.
//

import SwiftUI

public struct SegmentedPicker<T: Pickerable>: View {

    @Binding private var selection: T
    private let title: String
    private let elements: [T]

    public init(_ title: String, selection: Binding<T>, elements: [T]) {
        self.title = title
        self._selection = selection
        self.elements = elements
    }

    public var body: some View {
        Picker(title, selection: $selection.animation(.easeInOut(duration: 0.3))) {
            ForEach(elements) {
                Text($0.valueName).tag($0)
            }
        }
        .pickerStyle(.segmented)
    }
}

// MARK: - Preview

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        let elements = ["Value 1", "Value 2", "Value 3"]
        Group {
            SegmentedPicker("Picker", selection: .constant("Value 1"), elements: elements)
            SegmentedPicker("Picker", selection: .constant("Value 1"), elements: elements).darkScheme()
        }
        .sizeThatFits()
    }
}
