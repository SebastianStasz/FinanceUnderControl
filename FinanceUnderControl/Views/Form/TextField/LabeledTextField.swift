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
    private let prompt: Text?

    public init(title: String,
                input: Binding<Input>,
                prompt: String? = nil
    ) {
        self._input = input
        self.title = title
        self.prompt = prompt != nil ? Text(prompt!) : nil
    }

    var body: some View {
        HStack(spacing: 0) {
            Text(title)
            Text(viewModel.text)

            TextField(title, text: $viewModel.text, prompt: prompt)
                .multilineTextAlignment(.trailing)
                .asInputView(viewModel: viewModel, input: $input)
        }
    }
}


// MARK: - Preview

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            LabeledTextField<NumberInputVM>(title: "Input", input: .constant(.init()))
        }
    }
}
