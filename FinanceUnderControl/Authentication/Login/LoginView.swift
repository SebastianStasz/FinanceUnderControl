//
//  LoginView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Shared
import SwiftUI
import SSUtils

struct LoginView: BaseView {

    private enum Field {
        case email, password
    }

    @ObservedObject var viewModel: LoginVM
    @FocusState private var focusedField: Field?

    var baseBody: some View {
        VStack(alignment: .center, spacing: .xxlarge) {

            VStack(spacing: .xxlarge) {
                VStack(spacing: .large) {
                    BaseTextField("Email", viewModel: viewModel.emailInput, keyboardType: .emailAddress)
                        .focused($focusedField, equals: .email)
                        .onTapGesture { focusedField = .email }
                        .textInputAutocapitalization(.never)

                    BaseTextField("Password", viewModel: viewModel.passwordInput, isSecure: true, validationMessage: viewModel.passwordMessage)
                        .focused($focusedField, equals: .password)
                        .onTapGesture { focusedField = .password }
                        .textInputAutocapitalization(.never)
                }
                .onSubmit(didSubmit)

                BaseButton("Sign in", role: .primary, action: didTapSignIn)
                    .disabled(!viewModel.isFormValid)
            }

            HStack(spacing: .small) {
                Rectangle().frame(height: 1).foregroundColor(.gray).opacity(0.2)
                Text("or", style: .footnote()).opacity(0.6)
                Rectangle().frame(height: 1).foregroundColor(.gray).opacity(0.2)
            }
            .padding(.horizontal, .xxlarge)

            BaseButton("Sign up", role: .secondary, action: didTapSignUp)
        }
        .doubleTitle(title: "Hello!", subtitle: "Sign in and start managing your finances just now!")
        .onTapGesture { focusedField = nil }
        .handleViewModelActions(viewModel)
    }

    private func didTapSignUp() {
        focusedField = nil
        viewModel.binding.navigateTo.send(.didTapSignUp)
    }

    private func didTapSignIn() {
        viewModel.binding.didTapSignIn.send()
    }

    private func didSubmit() {
        if focusedField == .email {
            focusedField = .password
        } else {
            focusedField = nil
            didTapSignIn()
        }
    }
}

// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LoginVM(coordinator: PreviewCoordinator())
        LoginView(viewModel: viewModel)
        LoginView(viewModel: viewModel).darkScheme()
    }
}
