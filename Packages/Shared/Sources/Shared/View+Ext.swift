//
//  View+Ext.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI
import SSUtils

public extension View {

    func sizeThatFits() -> some View {
        self.padding(.medium).previewLayout(.sizeThatFits)
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
