//
//  BaseRowButtonStyle.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import SwiftUI

struct BaseRowButtonStyle: ButtonStyle {

    let buttonType: BaseRowButtonType

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .medium) {
            configuration.label

            if let image = buttonType.systemImage {
                Image(systemName: image)
                    .opacity(0.4)
            }
        }
        .contentShape(Rectangle())
        .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
