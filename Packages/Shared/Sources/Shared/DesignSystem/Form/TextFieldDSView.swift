//
//  TextFieldDSView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SSValidation
import SwiftUI

struct TextFieldDSView: View {

    @State private var textInput = TextInputVM(validator: .notEmpty().and(.lengthBetween(3...9)))
    @State private var numberInput = DoubleInputVM(validator: .notEmpty().andDouble(.valueBetween(3...9)))

    var body: some View {
        Group {
            LabeledTextField("Enter number", viewModel: numberInput)
                .designSystemComponent("Labeled text field")
        }
        .designSystemView("Text Fields")
    }
}

// MARK: - Preview

struct TextFieldDSView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDSView()
        TextFieldDSView().darkScheme()
    }
}
