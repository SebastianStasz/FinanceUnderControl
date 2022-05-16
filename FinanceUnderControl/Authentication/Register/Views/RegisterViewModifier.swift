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

    let type: RegisterViewType

    func body(content: Content) -> some View {
        VStack {
            content
                .focused($isFieldFocused)
                .textInputAutocapitalization(.never)
                .doubleTitle(title: type.title, subtitle: type.subtitle)

            BaseButton("Confirm", role: .primary, action: didTapConfirm)
                .disabled(!isConfirmEnabled)
                .padding([.horizontal, .bottom], .medium)
        }
        .background(Color.backgroundPrimary)
        .onAppearFocus($isFieldFocused)
        .onAppear { viewDidAppear() }
        .onSubmit(didSubmit)
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

    private func didSubmit() {
        if isConfirmEnabled { didTapConfirm() }
    }

    private func didTapConfirm() {
        switch type {
        case .email:
            viewModel.binding.navigateTo.send(.didConfirmEmail)
        case .password:
            viewModel.binding.navigateTo.send(.didEnterPassword)
        case .passwordConfirmation:
            viewModel.binding.didConfirmRegistration.send()
        }
    }

    private func viewDidAppear() {
        if case .email = type {
            viewModel.passwordInput.setText(to: "")
            viewModel.confirmPasswordInput.setText(to: "")
        } else if case .password = type {
            viewModel.confirmPasswordInput.setText(to: "")
        }
    }
}

extension View {
    func asRegisterView(for type: RegisterViewType) -> some View {
        modifier(RegisterViewModifier(type: type))
    }
}
