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
    @State private var isRegisterViewPresented = false

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
                    VStack(spacing: .xxlarge) {
                        VStack(spacing: .large) {
                            LabeledTextField("Email", viewModel: viewModel.emailInput, keyboardType: .emailAddress)
                            LabeledTextField("Password", viewModel: viewModel.passwordInput, isSecure: true)
                        }
                        BaseButton("Sign in", role: .primary, action: {})
                            .disabled(true)
                    }
                    .padding(.horizontal, .medium)

                    HStack(spacing: .small) {
                        Rectangle().frame(height: 1).foregroundColor(.gray).opacity(0.2)
                        Text("or", style: .footnote()).opacity(0.6)
                        Rectangle().frame(height: 1).foregroundColor(.gray).opacity(0.2)
                    }
                        .padding(.horizontal, .xxlarge)

                    BaseButton("Sign up", role: .secondary) { isRegisterViewPresented = true }
                        .padding(.horizontal, .medium)
                }

                Spacer()

            }
        }
        .background(Color.backgroundPrimary)
        .embedInNavigationView(title: "", displayMode: .inline)
        .fullScreenCover(isPresented: $isRegisterViewPresented, content: RegisterView.init)
    }
}

// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        LoginView().darkScheme()
    }
}
