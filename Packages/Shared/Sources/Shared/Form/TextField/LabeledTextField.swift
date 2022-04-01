//
//  LabeledTextField.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 07/12/2021.
//

import SwiftUI
import SSValidation

public struct LabeledTextField<T>: View {

    @ObservedObject private var viewModel: InputVM<T>

    private let title: String
    private let style: CardStyle

    public init(_ title: String,
                viewModel: InputVM<T>,
                style: CardStyle = .primary
    ) {
        self.title = title
        self.viewModel = viewModel
        self.style = style
    }

    public var body: some View {
        VStack(spacing: .micro) {
            InputField(title, viewModel: viewModel, prompt: title).textStyle(.body())

            if let message = viewModel.validationMessage {
                Text(message, style: .validation)
            }
        }
        .card(style: style)
    }
}

// MARK: - Preview

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LabeledTextField("Field name", viewModel: TextInputVM())
            LabeledTextField("Field name", viewModel: TextInputVM()).darkScheme()
        }
        .sizeThatFits()
    }
}
