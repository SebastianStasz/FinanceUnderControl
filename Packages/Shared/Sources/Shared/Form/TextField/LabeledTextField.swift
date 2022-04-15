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

    public init(_ title: String,
                viewModel: InputVM<T>,
                prompt: String? = nil,
                style: CardStyle = .primary
    ) {
        self.title = title
        self.viewModel = viewModel
        self.prompt = prompt
        self.style = style
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .micro) {
            InputField(title, viewModel: viewModel, prompt: prompt ?? title).textStyle(.body())

            if let message = viewModel.validationMessage {
                Text(message, style: .footnote(.validation))
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
