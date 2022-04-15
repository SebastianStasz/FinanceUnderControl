//
//  TextDSView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 15/04/2022.
//

import SwiftUI

struct TextDSView: View {

    var body: some View {
        Group {
            Text("Headline big", style: .headlineBig)

            Text("Headline small - normal", style: .headlineSmall(.normal))
            Text("Headline small - action", style: .headlineSmall(.action))

            Text("Body medium", style: .bodyMedium)

            Text("Body - normal", style: .body(.normal))
            Text("Body - action", style: .body(.action))

            Text("Footnote - info", style: .footnote(.info))
            Text("Footnote - validation", style: .footnote(.validation))

            Text("Currency", style: .currency)
        }
        .designSystemView("Texts")
    }
}

// MARK: - Preview

struct TextDSView_Previews: PreviewProvider {
    static var previews: some View {
        TextDSView()
        TextDSView().darkScheme()
    }
}
