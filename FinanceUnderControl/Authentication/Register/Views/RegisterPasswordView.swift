//
//  RegisterPasswordView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/04/2022.
//

import Shared
import SwiftUI

struct RegisterPasswordView: View {

    @ObservedObject var viewModel: RegisterVM

    var body: some View {
        VStack(spacing: .medium) {
            LabeledTextField("Password", viewModel: viewModel.passwordInput, isSecure: true)
            RegisterPasswordHintView(viewData: viewModel.passwordHintVD)
        }
        .asRegisterView(for: .password)
        .environmentObject(viewModel)
    }
}

// MARK: - Preview

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RegisterVM(coordinator: PreviewCoordinator())
        RegisterPasswordView(viewModel: viewModel)
        RegisterPasswordView(viewModel: viewModel).darkScheme()
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
