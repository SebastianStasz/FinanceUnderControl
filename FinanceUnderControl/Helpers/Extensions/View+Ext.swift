//
//  View+Ext.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/02/2022.
//

import SwiftUI
import SSUtils
import Shared

extension View {
    func cornerRadius(_ radius: CornerRadius) -> some View {
        self.cornerRadius(radius.rawValue)
    }

    func formField() -> some View {
        self.infiniteWidth(alignment: .leading)
            .padding(.medium)
            .background(Color.backgroundSecondary)
            .cornerRadius(.base)
    }
}
