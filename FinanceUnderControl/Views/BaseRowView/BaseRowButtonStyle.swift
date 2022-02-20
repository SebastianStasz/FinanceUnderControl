//
//  BaseRowButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import SwiftUI

struct BaseRowButtonStyle: ButtonStyle {

    let buttonType: BaseRowButtonType
    let isBlue: Bool

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .large) {
            configuration.label

            Spacer()

            if let image = buttonType.systemImage {
                Image(systemName: image).opacity(0.4)
            }
        }
        .foregroundColor(isBlue ? .blue : .primary)
        .contentShape(Rectangle())
        .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
