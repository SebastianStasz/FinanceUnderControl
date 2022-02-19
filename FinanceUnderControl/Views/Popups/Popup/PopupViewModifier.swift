//
//  PopupViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import Shared
import SwiftUI

struct PopupViewModifier: ViewModifier {
    @EnvironmentObject var appController: AppController

    let title: String
    let action: () -> Void
    let isActionDisabled: Bool

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.bottom, .big)

            content

            HStack(spacing: .medium) {
                BaseButton("Cancel", role: .secondary, action: dismissPopup)
                BaseButton("Create", role: .primary, action: performAction)
                    .disabled(isActionDisabled)
            }
            .padding(.top, .medium)
        }
        .padding(.medium)
        .frame(width: UIScreen.screenWidth - 2 * Spacing.medium.rawValue)
        .background(Color.backgroundSecondary)
        .cornerRadius(.base)
    }

    private func performAction() {
        action()
        dismissPopup()
    }
}

extension View {
    func asPopup(title: String, isActionDisabled: Bool = false, action: @escaping () -> Void) -> some View {
        modifier(PopupViewModifier(title: title,
                                   action: action,
                                   isActionDisabled: isActionDisabled))
    }
}
