//
//  Button+Ext.swift
//  Shared
//
//  Created by sebastianstaszczyk on 01/04/2022.
//

import SwiftUI

public extension Button where Label == SwiftUI.Label<SwiftUI.Text, Image> {

    static func cancel(action: @escaping () -> Void) -> some View {
        Button(role: .cancel, action: action) {
            Label("Cancel", systemImage: SFSymbol.close.name)
        }
    }

    @ViewBuilder
    static func delete(titleOnly: Bool = false, action: @escaping () -> Void) -> some View {
        if titleOnly {
            deleteBtn(action: action).labelStyle(.titleOnly)
        } else {
            deleteBtn(action: action)
        }
    }

    static func edit(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label("Edit", systemImage: SFSymbol.infoCircle.name)
        }
        .tint(.gray)
    }

    // MARK: - Helper

    private static func deleteBtn(action: @escaping () -> Void) -> some View {
        Button(role: .destructive, action: action) {
            Label("Delete", systemImage: SFSymbol.trash.name)
        }
        .foregroundColor(.red)
    }
}
