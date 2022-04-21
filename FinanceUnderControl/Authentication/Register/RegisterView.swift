//
//  RegisterView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Shared
import SwiftUI

struct RegisterView: View {

    @StateObject private var viewModel = RegisterVM()

    var body: some View {
        FormView {
            LabeledTextField("Email", viewModel: viewModel.emailInput)
                .embedInSection("Email")

            LabeledTextField("Password", viewModel: viewModel.passwordInput)
                .embedInSection("Password")
        }
        .asSheet(title: "Register", primaryButton: primaryButton)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init("Register", action: viewModel.register)
    }
}

// MARK: - Preview

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
