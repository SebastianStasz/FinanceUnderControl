//
//  Description.swift
//  Shared
//
//  Created by sebastianstaszczyk on 12/04/2022.
//

import SwiftUI

public struct Description: View {

    private let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text, style: .footnote(.info))
            .padding(.horizontal, .medium)
    }
}

// MARK: - Preview

struct Description_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Description("Sample content of description view.")
            Description("Sample content of description view.").darkScheme()
        }
        .sizeThatFits()
    }
}
