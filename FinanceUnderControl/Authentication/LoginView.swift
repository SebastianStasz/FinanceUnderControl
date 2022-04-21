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

    var body: some View {
        FormView {
            Spacer()
            Group {
                LabeledTextField("Email", viewModel: viewModel.emailInput)
                    .embedInSection("Email")

                LabeledTextField("Password", viewModel: viewModel.passwordInput)
                    .embedInSection("Password")

                BaseButton("Login", role: .primary, action: viewModel.login)
                    .padding(.horizontal, .medium)
            }

            Spacer()
        }
        .embedInNavigationView(title: "Finance Under Control")
    }
}

// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
