//
//  RegisterViewModifier.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/04/2022.
//

import Shared
import SwiftUI

private struct RegisterViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: RegisterVM
    @FocusState private var isFieldFocused: Bool
    @State private var isNextViewPresented = false

    let type: RegisterViewType

    func body(content: Content) -> some View {
        VStack {
            content
                .focused($isFieldFocused)
                .doubleTitle(title: type.title, subtitle: type.subtitle)

            BaseButton("Confirm", role: .primary, action: didTapConfirm)
                .disabled(!isConfirmEnabled)
                .padding(.horizontal, .medium)
                .padding(.bottom, isFieldFocused ? .medium : 0)
        }
        .background(Color.backgroundPrimary)
        .onAppearFocus($isFieldFocused)
        .navigation(isActive: $isNextViewPresented) { type.nextView }
        .onReceive(viewModel.binding.dismissView, perform: dismiss.callAsFunction)
    }

    private var isConfirmEnabled: Bool {
        switch type {
        case .email:
            return viewModel.isEmailValid
        case .password:
            return viewModel.passwordHintVD.isValid
        case .passwordConfirmation:
            return viewModel.isPasswordConfirmationValid
        }
    }

    private func didTapConfirm() {
        switch type {
        case .email:
            isNextViewPresented = true
        case .password:
            isNextViewPresented = true
        case .passwordConfirmation:
            viewModel.binding.didConfirmRegistration.send()
        }
    }
}

extension View {
    func asRegisterView(for type: RegisterViewType) -> some View {
        modifier(RegisterViewModifier(type: type))
    }
}
