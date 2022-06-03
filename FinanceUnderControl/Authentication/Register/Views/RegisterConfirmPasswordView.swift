//
//  RegisterConfirmPasswordView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/04/2022.
//

import Shared
import SwiftUI

struct RegisterConfirmPasswordView: View {
    @ObservedObject var viewModel: RegisterVM

    var body: some View {
        BaseTextField("Confirm password", viewModel: viewModel.confirmPasswordInput, isSecure: true)
            .asRegisterView(for: .passwordConfirmation)
            .environmentObject(viewModel)
            .handleViewModelActions(viewModel)
    }
}

// MARK: - Preview

struct RegisterConfirmPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RegisterVM(coordinator: PreviewCoordinator())
        RegisterConfirmPasswordView(viewModel: viewModel)
        RegisterConfirmPasswordView(viewModel: viewModel).darkScheme()
    }
}
