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
    private let content: () -> Content

    public init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    public var body: some View {
        HStack(spacing: .medium) {
            Text(title).lineLimit(1)

            Spacer()

            content().infiniteWidth(alignment: .trailing)
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
