//
//  Text.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

public struct Text: View {

    private let text: String
    private let style: TextStyle

    public init(_ text: String, style: TextStyle = .body()) {
        self.text = text
        self.style = style
    }

    public init?(_ text: String?, style: TextStyle = .body()) {
        guard let text = text else { return nil }
        self.init(text, style: style)
    }

    public var body: some View {
        SwiftUI.Text(text).textStyle(style)
    }
}

// MARK: - Preview

struct Text_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("Text body")
            Text("Text body").darkScheme()
        }
        .sizeThatFits()
    }
}
