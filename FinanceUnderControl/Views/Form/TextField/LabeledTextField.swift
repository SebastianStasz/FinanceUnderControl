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
    private let style: CardStyle

    public init(_ title: String,
                input: Binding<Input>,
                prompt: String? = nil,
                style: CardStyle = .primary
    ) {
        self._input = input
        self.title = title
        self.prompt = prompt != nil ? SwiftUI.Text(prompt!) : nil
        self.style = style
    }

    var body: some View {
        VStack(spacing: .micro) {
            HStack(spacing: .large) {
                Text("\(title):")

                TextField(title, text: $viewModel.textField, prompt: prompt)
                    .multilineTextAlignment(.trailing)
                    .asInputView(viewModel: viewModel, input: $input)
            }
            if let message = viewModel.message {
                Text(message, style: .validation)
            }
        }.card(style: style)
    }
}


// MARK: - Preview

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabeledInputNumber("Field name", input: .constant(.init(settings: .init(dropFirst: false))))
            .asPreview()
    }
}
