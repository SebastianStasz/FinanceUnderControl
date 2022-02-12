//
//  Typography.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import SwiftUI

public extension View {

    var textHeadlineBig: some View {
        self.font(.system(.title3).weight(.medium))
            .foregroundColor(.white)
    }

    var textBodyMedium: some View {
        self.font(.callout.weight(.medium))
            .foregroundColor(.basicPrimaryInverted)
    }

    var textBodyNormal: some View {
        self.font(.callout.weight(.regular))
            .foregroundColor(.grayMedium)
    }

    var currencySymbol: some View {
        self.font(.system(.body, design: .monospaced).weight(.medium))
            .textCase(.uppercase)
    }
}
