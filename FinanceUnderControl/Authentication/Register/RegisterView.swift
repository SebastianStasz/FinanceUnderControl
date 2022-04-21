//
//  RegisterView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Shared
import SwiftUI

struct RegisterView: BaseView {

    @StateObject private var viewModel = RegisterVM()

    var baseBody: some View {
        FormView {
            LabeledTextField("Email", viewModel: viewModel.emailInput)
                .embedInSection("Email")

            LabeledTextField("Password", viewModel: viewModel.passwordInput)
                .embedInSection("Password")
        }
        .asSheet(title: "Register", primaryButton: primaryButton)
        .handleViewModelActions(viewModel)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init("Register", action: register)
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
