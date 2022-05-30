//
//  Button+Ext.swift
//  Shared
//
//  Created by sebastianstaszczyk on 01/04/2022.
//

import SwiftUI

public extension Button where Label == SwiftUI.Label<SwiftUI.Text, Image> {

    static func cancel(action: @escaping Action) -> some View {
        Button(role: .cancel, action: action) {
            Label(String.common_cancel, systemImage: SFSymbol.close.name)
        }
    }

    @ViewBuilder
    static func delete(titleOnly: Bool = false, action: @escaping Action) -> some View {
        if titleOnly {
            deleteBtn(action: action).labelStyle(.titleOnly)
        } else {
            deleteBtn(action: action)
        }
    }

    static func edit(action: @escaping Action) -> some View {
        Button(action: action) {
            Label(String.common_edit, systemImage: SFSymbol.infoCircle.name)
        }
        .tint(.gray)
    }

    // MARK: - Helper

    private static func deleteBtn(action: @escaping Action) -> some View {
        Button(role: .destructive, action: action) {
            Label(String.common_delete, systemImage: SFSymbol.trash.name)
        }
        .foregroundColor(.red)
    }
}
