//
//  BaseTextField.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 07/12/2021.
//

import SwiftUI
import SSValidation

public struct BaseTextField<T>: View {

    @ObservedObject private var viewModel: InputVM<T>
    @FocusState private var isFocused: Bool

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
            HStack(spacing: .medium) {
                InputField(title, viewModel: viewModel, prompt: prompt ?? title, isSecure: isSecure, keyboardType: keyboardType)
                    .textStyle(.body())
                    .focused($isFocused)

                Button(systemImage: SFSymbol.clear.rawValue) {
                    viewModel.setText("")
                }
                .buttonStyle(.plain)
                .opacity(isClearButtonVisible ? 0.3 : 0)
            }
            .frame(height: 48)
            .padding(.horizontal, .medium)
            .background(style.color)
            .cornerRadius(.base)

            if let message = message {
                Text(message, style: .footnote(.invalid))
                    .padding(.leading, .micro)
            }
        }
    }

    private var message: String? {
        if let message = validationMessage {
            return message
        } else if let message = viewModel.validationMessage, showValidation {
            return message
        }
        return nil
    }

    private var isClearButtonVisible: Bool {
        guard isFocused else { return false }
        return viewModel.textInput.isNotEmpty
    }
}

// MARK: - Preview

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BaseTextField("Field name", viewModel: TextInputVM())
            BaseTextField("Field name", viewModel: TextInputVM()).darkScheme()
        }
        .sizeThatFits()
    }
}
