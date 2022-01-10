//
//  BaseButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {

    let role: ButtonRole

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textHeadlineBig
            .infiniteWidth()
            .padding(.small)
            .background(role.background)
            .foregroundColor(.white)
            .cornerRadius(.radiusBase)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
