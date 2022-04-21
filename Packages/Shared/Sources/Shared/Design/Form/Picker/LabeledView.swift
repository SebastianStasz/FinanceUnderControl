//
//  LabeledView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 29/03/2022.
//

import SSUtils
import SwiftUI

public struct LabeledView<Content: View>: View {

    private let title: String
    private let validationMessage: String?
    private let content: () -> Content

    public init(_ title: String, validationMessage: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.validationMessage = validationMessage
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .micro) {
            HStack(spacing: .medium) {
                Text(title).lineLimit(1)

                Spacer()

                content().infiniteWidth(alignment: .trailing)
            }
            
            if let message = validationMessage {
                Text(message, style: .footnote(.validation))
            }
        }
        .card()
    }
}

// MARK: - Preview

struct LabeledView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LabeledView("Title") { Text("CONTENT") }
            LabeledView("Title") { Text("CONTENT") }.darkScheme()
        }
        .sizeThatFits()
    }
}
