//
//  RegisterView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Shared
import SwiftUI
import SSUtils

struct RegisterView: BaseView {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = RegisterVM()

    var baseBody: some View {
        VStack {
            VStack(spacing: .xxlarge) {
                VStack(spacing: .large) {
                    LabeledTextField("Email", viewModel: viewModel.emailInput, keyboardType: .emailAddress)
                    LabeledTextField("Password", viewModel: viewModel.passwordInput, isSecure: true)
                }
                BaseButton("Sign in", role: .primary, action: {})
                    .disabled(true)
            }
        }
        .toolbar { Toolbar.trailing(systemImage: SFSymbol.close.rawValue) { dismiss.callAsFunction() } }
        .doubleTitle(title: "Sign up", subtitle: "First enter your email adress, that will be used to create your account.")
        .embedInNavigationView(title: "", displayMode: .inline)
    }

    // MARK: - Interactions

    private func register() {
        viewModel.input.didTapRegister.send()
    }
}

// MARK: - Preview

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
