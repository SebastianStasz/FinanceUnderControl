//
//  Text.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/02/2022.
//

import SwiftUI
import Shared

struct Text: View {

    private let text: String
    private let style: TextStyle

    init(_ text: String, style: TextStyle = .body) {
        self.text = text
        self.style = style
    }

    var body: some View {
        Shared.Text(text, style: style)
    }
}
