//
//  LabeledTextField.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 07/12/2021.
//

import Shared
import SwiftUI
import SSValidation

struct LabeledTextField<ViewModel: InputVM>: View {
    public typealias Input = ViewModel.InputField

    @StateObject private var viewModel = ViewModel()
    @Binding private var input: Input

    private let title: String
    private let style: CardStyle

    public init(_ title: String,
                input: Binding<Input>,
                style: CardStyle = .primary
    ) {
        self._input = input
        self.title = title
        self.style = style
    }

    var body: some View {
        VStack(spacing: .micro) {
            TextField(title, text: $viewModel.textField, prompt: SwiftUI.Text(title))
                .asInputView(viewModel: viewModel, input: $input)

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
