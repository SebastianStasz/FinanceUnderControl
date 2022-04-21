//
//  LoginView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Shared
import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginVM()
    @State private var isRegisterViewShown = false

    var body: some View {
        FormView {
            LabeledTextField("Email", viewModel: viewModel.emailInput)
                .embedInSection("Email")

            LabeledTextField("Password", viewModel: viewModel.passwordInput)
                .embedInSection("Password")

            VStack(spacing: .medium) {
                BaseButton("Login", role: .primary, action: viewModel.login)
                    .padding(.horizontal, .medium)

                BaseButton("Register", role: .secondary, action: showRegisterView)
                    .padding(.horizontal, .medium)
            }
        }
        .embedInNavigationView(title: "Finance Under Control", displayMode: .large)
        .sheet(isPresented: $isRegisterViewShown, content: RegisterView.init)
    }

    private func showRegisterView() {
        isRegisterViewShown = true
    }
}

// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
