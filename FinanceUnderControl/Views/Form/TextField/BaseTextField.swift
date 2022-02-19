//
//  BaseTextField.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI
import SSValidation

struct BaseTextField<ViewModel: InputVM>: View {
    public typealias Input = ViewModel.InputField

    @StateObject private var viewModel = ViewModel()
    @Binding private var input: Input

    private let title: String
    private let prompt: SwiftUI.Text?

    public init(title: String,
                input: Binding<Input>,
                prompt: String? = nil) {
        self._input = input
        self.title = title
        self.prompt = prompt != nil ? SwiftUI.Text(prompt!) : nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .micro) {
            TextField(title, text: $viewModel.textField, prompt: prompt)
                .textFieldStyle(.roundedBorder)

            Text(viewModel.message ?? "")
                .foregroundColor(.red)
                .font(.footnote)
        }
        .asInputView(viewModel: viewModel, input: $input)
    }
}


// MARK: - Preview

struct BaseTextField_Previews: PreviewProvider {
    static var previews: some View {
        let textInput = Input<TextInputSettings>()
        BaseTextField<TextInputVM>(title: "Text input", input: .constant(textInput))
    }
}
