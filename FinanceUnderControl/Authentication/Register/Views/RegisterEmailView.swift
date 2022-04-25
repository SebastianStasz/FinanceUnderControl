//
//  RegisterEmailView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/04/2022.
//

import Shared
import SwiftUI

struct RegisterEmailView: BaseView {
    @ObservedObject var viewModel = RegisterVM()

    var baseBody: some View {
        LabeledTextField("Email", viewModel: viewModel.emailInput, showValidation: false, keyboardType: .emailAddress)
            .asRegisterView(for: .email)
            .environmentObject(viewModel)
    }
}

// MARK: - Preview

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView(viewModel: .init())
        RegisterEmailView(viewModel: .init()).darkScheme()
    }
}
