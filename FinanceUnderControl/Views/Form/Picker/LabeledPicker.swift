//
//  LabeledPicker.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 12/01/2022.
//

import CoreData
import Shared
import SwiftUI

struct LabeledPicker<T: Pickerable>: View {

    @Binding private var selection: T?
    private let elements: [T]
    private let title: String

    var body: some View {
        HStack(spacing: .large) {
            Text(title)

            Spacer()

            Menu {
                Picker(title, selection: $selection) {
                    ForEach(elements, id: \.self) {
                        Text($0.valueName).tag(Optional($0))
                    }
                }
            } label: {
                HStack {
                    Spacer()
                    Text(selection?.valueName ?? "---")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 12)
                        .foregroundColor(.black)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
            }
        }
        .formField()
    }

    init(_ title: String, elements: [T], selection: Binding<T?>) {
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
        LabeledPicker("Labeled picker:", elements: elements, selection: .constant("Value 1"))
            .padding(.large)
    }
}
