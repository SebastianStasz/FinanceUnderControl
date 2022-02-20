//
//  TextFieldDSView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI
import SSValidation
import Shared

struct TextFieldDSView: View {

    @State private var textInput = Input<TextInputSettings>(settings: .init(minLength: 3))
    @State private var numberInput = Input<NumberInputSettings>(settings: .init(minValue: 3))

    var body: some View {
        Group {
            LabeledInputNumber("Enter Number", input: $numberInput, prompt: "100")
                .designSystemComponent("Labeled text field")
            
            BaseInputText(title: "Name", input: $textInput)
                .designSystemComponent("Base text field")
        }
        .designSystemView("Text Fields")
    }
}


// MARK: - Preview

struct TextFieldDSView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDSView().embedInNavigationView()
    }
}
