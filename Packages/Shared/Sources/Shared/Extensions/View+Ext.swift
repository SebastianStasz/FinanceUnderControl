//
//  View+Ext.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI
import SSUtils

public extension View {

    func darkScheme() -> some View {
        self.preferredColorScheme(.dark)
    }

    func sizeThatFits(backgroundColor: Color = .backgroundPrimary, spacing: Bool = true) -> some View {
        self.padding(spacing ? .large : 0)
            .background(backgroundColor)
            .previewLayout(.sizeThatFits)
    }

    func cornerRadius(_ radius: CornerRadius) -> some View {
        self.cornerRadius(radius.rawValue)
    }

    func card(style: CardStyle = .primary) -> some View {
        self.infiniteWidth(alignment: .leading)
            .padding(.medium)
            .background(style.color)
            .cornerRadius(.base)
    }

    func enabled(_ isEnabled: Bool) -> some View {
        disabled(!isEnabled)
            .opacity(isEnabled ? 1 : 0.4)
    }
}
