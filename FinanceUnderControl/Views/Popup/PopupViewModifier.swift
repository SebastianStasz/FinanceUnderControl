//
//  PopupViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import Shared
import SwiftUI

private struct PopupViewModifier: ViewModifier {

    let title: String
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(title)
                .padding(.bottom, .big)

            content

            HStack(spacing: .medium) {
                Button("Cancel", action: closePopup)
                    .buttonStyle(BaseButtonStyle(role: .cancel))
                Button("Create", action: ())
                    .buttonStyle(BaseButtonStyle(role: .action))
            }
            .padding(.top, .medium)
        }
        .padding(.medium)
        .frame(width: UIScreen.screenWidth - 2 * Spacing.medium.rawValue)
        .background(Color.backgroundSecondary)
        .cornerRadius(.radiusBase)
    }

    private func closePopup() {
        isPresented = false
    }
}

extension View {
    func asPopup(title: String, isPresented: Binding<Bool>) -> some View {
        modifier(PopupViewModifier(title: title, isPresented: isPresented))
    }
}
