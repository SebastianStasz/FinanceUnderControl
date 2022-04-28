//
//  BaseButtonStyle.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI
import SSUtils

struct BaseButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    let role: BaseButton.Role

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(.headlineLarge)
            .infiniteWidth()
            .padding(.medium)
            .background(role.background)
            .foregroundColor(.white)
            .cornerRadius(.base)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .opacity(isEnabled ? 1 : 0.3)
    }
}
