//
//  ButtonDSView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 21/01/2022.
//

import SwiftUI

public struct ButtonDSView: View {

    public init() {}

    public var body: some View {
        Group {
            Button.edit {}
                .designSystemComponent("Button - edit")

            Button.cancel {}
                .designSystemComponent("Button - cancel")

            Button.delete {}
                .designSystemComponent("Button - delete")
            
            BaseButton("Button title", role: .primary, action: {})
                .designSystemComponent("Base Button - primary")

            BaseButton("Button title", role: .secondary, action: {})
                .designSystemComponent("Base Button - secondary")
        }
        .designSystemView("Buttons")
    }
}

// MARK: - Preview

struct ButtonDSView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDSView()
        ButtonDSView().darkScheme()
    }
}
