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

    func sizeThatFits(backgroundColor: Color = .backgroundPrimary) -> some View {
        self.padding(.large)
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
}
