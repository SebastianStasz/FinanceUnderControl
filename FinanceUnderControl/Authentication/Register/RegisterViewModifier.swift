//
//  RegisterViewModifier.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/04/2022.
//

import Shared
import SwiftUI

private struct RegisterViewModifier: ViewModifier {
    @EnvironmentObject private var viewModel: RegisterVM
    @FocusState private var isFieldFocused: Bool
    @State private var isNextViewPresented = false

    let type: RegisterViewType

    func body(content: Content) -> some View {
        VStack {
            content
                .focused($isFieldFocused)
                .doubleTitle(title: type.title, subtitle: type.subtitle)

            BaseButton("Confirm", role: .primary) {
                isNextViewPresented = true
            }
            .disabled(!isConfirmEnabled)
            .padding(.horizontal, .medium)
            .padding(.bottom, isFieldFocused ? .medium : 0)
        }
        .background(Color.backgroundPrimary)
        .onAppearFocus($isFieldFocused)
        .navigation(isActive: $isNextViewPresented) { type.nextView }
    }

    private var isConfirmEnabled: Bool {
        switch type {
        case .email:
            return viewModel.viewData.isEmailValid
        case .password:
            return viewModel.viewData.isPasswordValid
        case .passwordConfirmation:
            return viewModel.viewData.isConfirmPasswordValid
        }
    }
}

extension View {
    func asRegisterView(for type: RegisterViewType) -> some View {
        modifier(RegisterViewModifier(type: type))
    }
}
