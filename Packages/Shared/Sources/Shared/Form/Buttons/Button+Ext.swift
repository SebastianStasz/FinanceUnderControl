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

public extension Button where Label == SwiftUI.Text {

    static func cancel(_ action: @escaping () -> Void) -> some View {
        Button("Cancel", role: .cancel, action: action)
    }
}

public extension Button where Label == SwiftUI.Label<SwiftUI.Text, Image> {

    static func delete(_ action: @autoclosure @escaping () -> Void) -> some View {
        Button(role: .destructive, action: action) {
            Label("Delete", systemImage: SFSymbol.trash.name)
        }
    }

    static func delete(_ action: @escaping () -> Void) -> some View {
        Button(role: .destructive, action: action) {
            Label("Delete", systemImage: SFSymbol.trash.name)
        }
    }

    static func edit(_ action: @autoclosure @escaping () -> Void) -> some View {
        Button(action: action) {
            Label("Edit", systemImage: SFSymbol.infoCircle.name)
        }
        .tint(.gray)
    }

    static func edit(_ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label("Edit", systemImage: SFSymbol.infoCircle.name)
        }
        .tint(.gray)
    }
}
