//
//  Button+Ext.swift
//  Shared
//
//  Created by sebastianstaszczyk on 01/04/2022.
//

import SwiftUI

public extension Button where Label == Image {

    /// Creates a button that generates its label from a SFSymbol image.
    /// - Parameters:
    ///   - symbol: The case of system graphics availables in SFSymbol enum.
    ///   - action: The action to perform when the user triggers the button.
    init(symbol: SFSymbol, action: @escaping () -> Void) {
        self.init(action: action) { Image(systemName: symbol.name) }
    }
}
