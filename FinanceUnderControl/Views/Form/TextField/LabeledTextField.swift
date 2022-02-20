//
//  LabeledTextField.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 07/12/2021.
//

import SwiftUI
import SSValidation

struct LabeledTextField<ViewModel: InputVM>: View {
    public typealias Input = ViewModel.InputField

    @StateObject private var viewModel = ViewModel()
    @Binding private var input: Input

    private let title: String
    private let prompt: SwiftUI.Text?

    public init(_ title: String,
                input: Binding<Input>,
                prompt: String? = nil
    ) {
        self._input = input
        self.title = title
        self.prompt = prompt != nil ? SwiftUI.Text(prompt!) : nil
    }

    var body: some View {
        HStack {
            Text(title)

            TextField(title, text: $viewModel.textField, prompt: prompt)
                .multilineTextAlignment(.trailing)
                .asInputView(viewModel: viewModel, input: $input)
        }
    }
}


// MARK: - Preview

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            LabeledNumberInput("Input", input: .constant(.init()))
        }
    }
}
