//
//  RegisterConfirmPasswordView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/04/2022.
//

import Shared
import SwiftUI

struct RegisterConfirmPasswordView: View {
    @EnvironmentObject private var viewModel: RegisterVM

    var body: some View {
        LabeledTextField("Confirm password", viewModel: viewModel.confirmPasswordInput, isSecure: true)
            .asRegisterView(for: .passwordConfirmation)
    }
}

// MARK: - Preview

struct RegisterConfirmPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterConfirmPasswordView()
    }
}
