//
//  ButtonDSView.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 21/01/2022.
//

import SwiftUI

struct ButtonDSView: View {

    var body: some View {
        Group {
            Button.edit {}
                .designSystemComponent("Button - edit")

            Button.cancel {}
                .designSystemComponent("Button - cancel")

            Button.delete {}
                .designSystemComponent("Button - delete")
            
            BaseButton("Button title", role: .primary, action: {})
                .designSystemComponent("Base Button - action")

            BaseButton("Button title", role: .secondary, action: {})
                .designSystemComponent("Base Button - cancel")
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
