//
//  View+Ext.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/02/2022.
//

import Shared
import SwiftUI

extension View {

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
