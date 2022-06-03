//
//  TextDSView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 15/04/2022.
//

import SwiftUI

public struct TextDSView: View {

    public init() {}

    public var body: some View {
        VStack(alignment: .leading, spacing: .xxlarge) {
            Group {
                Text("Title", style: .title)
                Text("Subtitle", style: .subtitle)
                Text("Nav headline", style: .navHeadline)
            }

            Group {
                Text("Headline large", style: .headlineLarge)
                Text("Headline small - normal", style: .headlineSmall(.normal))
                Text("Headline small - action", style: .headlineSmall(.action))
            }

            Group {
                Text("Body medium", style: .bodyMedium)
                Text("Body - normal", style: .body(.normal))
                Text("Body - action", style: .body(.action))
            }

            Group {
                Text("Footnote - info", style: .footnote(.info))
                Text("Footnote - validation", style: .footnote(.invalid))
            }

            Group {
                Text("Currency", style: .currency)
            }
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
