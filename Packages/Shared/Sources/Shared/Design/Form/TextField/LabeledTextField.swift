//
//  LabeledTextField.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 07/12/2021.
//

import SwiftUI
import SSValidation

public struct LabeledTextField<T>: View {

    @ObservedObject private var viewModel: InputVM<T>

    private let title: String
    private let style: CardStyle
    private let prompt: String?
    private let showValidation: Bool
    private let isSecure: Bool
    private let validationMessage: String?
    private let keyboardType: UIKeyboardType?

    public init(_ title: String,
                viewModel: InputVM<T>,
                prompt: String? = nil,
                showValidation: Bool = true,
                isSecure: Bool = false,
                validationMessage: String? = nil,
                keyboardType: UIKeyboardType? = nil,
                style: CardStyle = .primary
    ) {
        self.title = title
        self.viewModel = viewModel
        self.prompt = prompt
        self.showValidation = showValidation
        self.isSecure = isSecure
        self.validationMessage = validationMessage
        self.keyboardType = keyboardType
        self.style = style
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .micro) {
            InputField(title, viewModel: viewModel, prompt: prompt ?? title, isSecure: isSecure, keyboardType: keyboardType).textStyle(.body())
                .card(style: style)

            if showValidation, let message = viewModel.validationMessage ?? validationMessage {
                Text(message, style: .footnote(.invalid))
                    .padding(.leading, .micro)
            }
        }
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
