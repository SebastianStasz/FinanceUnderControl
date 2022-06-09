//
//  MultilineTextField.swift
//  Shared
//
//  Created by sebastianstaszczyk on 04/06/2022.
//

import SwiftUI

public struct MultilineTextField: View {

    @Binding private var text: String
    private var placeholder: String

    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            TextEditor(text: $text)

            SwiftUI.Text(placeholder)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading, 4)
                .opacity(text.isEmpty ? 0.5 : 0)
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 2)
        .background(Color.backgroundSecondary)
        .cornerRadius(.base)
    }
}

struct MultilineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextField(text: .constant(""), placeholder: "Placeholder")
        MultilineTextField(text: .constant(""), placeholder: "Placeholder").darkScheme()
    }
}
