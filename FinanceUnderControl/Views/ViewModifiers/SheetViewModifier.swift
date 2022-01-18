//
//  SheetViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 17/01/2022.
//

import SwiftUI
import SSUtils
import Shared

private struct SheetViewModifier: ViewModifier {

    @Environment(\.dismiss) private var dismiss
    let title: String
    
    func body(content: Content) -> some View {
        content
            .toolbar { toolbarContent }
            .embedInNavigationView(title: title, displayMode: .inline)
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.close.name, action: dismiss.callAsFunction)
    }
}

extension View {
    func asSheet(title: String) -> some View {
        modifier(SheetViewModifier(title: title))
    }
}
