//
//  LabeledPicker.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 12/01/2022.
//

import CoreData
import SwiftUI

public struct LabeledPicker<T: Pickerable>: View {

    @Binding private var selection: T?
    private let elements: [T?]
    private let title: String

    public var body: some View {
        LabeledView("\(title):") {
            Menu {
                Picker(title, selection: $selection) {
                    ForEach(elements, id: \.self) {
                        Text($0?.valueName ?? "---").tag($0)
                    }
                }
            } label: {
                Text(selection?.valueName ?? "---", style: .body(.action))
                    .infiniteWidth(alignment: .trailing)
            }
        }
    }
}

public extension LabeledPicker {
    init(_ title: String, elements: [T?], selection: Binding<T?>) {
        self.title = title
        self.elements = elements
        self._selection = selection
    }

    init(_ title: String, elements: FetchedResults<T>, selection: Binding<T?>) where T: NSFetchRequestResult {
        self.title = title
        self.elements = elements.map { $0 }
        self._selection = selection
    }
}

// MARK: - Preview

struct LabeledPicker_Previews: PreviewProvider {
    static var previews: some View {
        let elements = ["Value 1", "Value 2", "Value 3", "Value 4"]
        Group {
            LabeledPicker("Picker title", elements: elements, selection: .constant("Value 1"))
            LabeledPicker("Picker title", elements: elements, selection: .constant("Value 1")).darkScheme()
        }
        .sizeThatFits()
    }
}