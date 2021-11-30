//
//  Typography.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import SwiftUI

public extension Text {

    var currencySymbol: some View {
        self.textCase(.uppercase)
            .font(.system(.body, design: .monospaced))
    }
}
