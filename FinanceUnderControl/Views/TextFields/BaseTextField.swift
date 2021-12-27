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
    private let prompt: Text?

    public init(title: String,
                input: Binding<Input>,
                prompt: String? = nil) {
        self._input = input
        self.title = title
        self.prompt = prompt != nil ? Text(prompt!) : nil
    }

    var body: some View {
        VStack(spacing: .medium) {
            TextField(title, text: $viewModel.text, prompt: prompt)

            if let message = viewModel.message {
                Text(message)
                    .foregroundColor(.red)
            }
        }
    }
}


// MARK: - Preview

struct BaseTextField_Previews: PreviewProvider {
    static var previews: some View {
        let textInput = Input<TextInputSettings>()
        BaseTextField<TextInputVM>(title: "Text input", input: .constant(textInput))
    }
}
