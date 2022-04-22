//
//  LoginView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Shared
import SwiftUI
import SSUtils

struct LoginView: View {

    @StateObject private var viewModel = LoginVM()

    var body: some View {
        ScrollViewIfNeeded {
            VStack(alignment: .center, spacing: 62) {

                VStack(alignment: .center, spacing: .large) {
                    SwiftUI.Text("Hello!")
                        .fontWeight(.semibold)
                        .font(.largeTitle)

                    SwiftUI.Text("Sign in and start managing your finances just now!")
                        .fontWeight(.thin)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, .xxlarge)
                }

                VStack(spacing: .xxlarge) {
                    VStack(spacing: .large) {
                        LabeledTextField("Email", viewModel: viewModel.emailInput, keyboardType: .emailAddress)
                        LabeledTextField("Password", viewModel: viewModel.passwordInput, isSecure: true)
                    }
                    BaseButton("Sign in", role: .primary, action: {})
                        .opacity(0.3)
                }
                .padding(.horizontal, .medium)

                Spacer()

            }
        }
        .background(Color.backgroundPrimary)
        .embedInNavigationView(title: "", displayMode: .inline)
    }
}

// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        LoginView().darkScheme()
    }
}
