//
//  RegisterPasswordView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/04/2022.
//

import Shared
import SwiftUI

struct RegisterPasswordView: View {

    @EnvironmentObject private var viewModel: RegisterVM

    var body: some View {
        VStack(spacing: .medium) {
            LabeledTextField("Password", viewModel: viewModel.passwordInput, isSecure: true)
            RegisterPasswordHintView(viewData: viewModel.passwordHintVD)
        }
        .asRegisterView(for: .password)
    }
}

// MARK: - Preview

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPasswordView()
    }
}

extension View {
    func onAppearFocus(_ isFieldFocused: FocusState<Bool>.Binding) -> some View {
        self.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isFieldFocused.wrappedValue = true
            }
        }
    }
}
