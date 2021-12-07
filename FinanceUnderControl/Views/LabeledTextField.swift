//
//  LabeledTextField.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 07/12/2021.
//

import SwiftUI

struct LabeledTextField: View {

    private let label: String
    @Binding private var value: String
    private let prompt: Text?

    init(label: String, value: Binding<String>, prompt: String? = nil) {
        self.label = label
        self._value = value
        self.prompt = prompt != nil ? Text(prompt!) : nil
    }

    var body: some View {
        HStack(spacing: 0) {
            Text(label)

            TextField(label, text: $value, prompt: prompt)
                .multilineTextAlignment(.trailing)
        }
    }
}


// MARK: - Preview

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            LabeledTextField(label: "Label", value: .constant("value"))
        }
    }
}
