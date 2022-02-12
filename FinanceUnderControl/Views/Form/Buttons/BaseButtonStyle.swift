//
//  BaseButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    let role: ButtonRole

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textHeadlineBig
            .infiniteWidth()
            .padding(.small)
            .background(role.background)
            .foregroundColor(.white)
            .cornerRadius(.base)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .opacity(isEnabled ? 1 : 0.3)
    }
}
