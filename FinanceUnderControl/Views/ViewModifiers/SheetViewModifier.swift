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
    @State private var isDismissConfirmationShown = false

    let title: String
    let askToDismiss: Bool
    let primaryButton: HorizontalButtons.Configuration?
    let secondaryButton: HorizontalButtons.Configuration?

    func body(content: Content) -> some View {
        content
            .toolbar { toolbarContent }
            .interactiveDismissDisabled()
            .embedInNavigationView(title: title, displayMode: .inline)
            .confirmationDialog("Dismiss", isPresented: $isDismissConfirmationShown) {
                Button("Discard changes", role: .destructive, action: dismiss.callAsFunction)
            }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.close.name, action: dismissSheet)
        ToolbarItem(placement: .bottomBar) {
            HorizontalButtons(primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }

    private func dismissSheet() {
        guard askToDismiss else {
            dismiss.callAsFunction() ; return
        }
        isDismissConfirmationShown = true
    }
}

extension View {
    func asSheet(title: String, askToDismiss: Bool = false) -> some View {
        modifier(SheetViewModifier(title: title, askToDismiss: askToDismiss, primaryButton: nil, secondaryButton: nil))
    }

    func asSheet(
        title: String,
        askToDismiss: Bool = false,
        primaryButton: HorizontalButtons.Configuration,
        secondaryButton: HorizontalButtons.Configuration? = nil
    ) -> some View {
        modifier(SheetViewModifier(title: title, askToDismiss: askToDismiss, primaryButton: primaryButton, secondaryButton: secondaryButton))
    }
}
