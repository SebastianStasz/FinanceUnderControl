//
//  RegisterCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Combine
import SwiftUI

final class RegisterCoordinator: Coordinator {

    override func initializeView() -> UIViewController {
        let viewModel = RegisterVM(coordinator: self)
        let view = RegisterEmailView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.addCloseButton()

        viewModel.binding.didConfirmEmail
            .sink { [weak self] in self?.presentPasswordView(viewModel: viewModel) }
            .store(in: &viewController.cancellables)

        viewModel.binding.didEnterPassword
            .sink { [weak self] in self?.presentPasswordConfirmationView(viewModel: viewModel) }
            .store(in: &viewController.cancellables)

        return viewController
    }

    private func presentPasswordView(viewModel: RegisterVM) {
        navigationController?.push(RegisterPasswordView(viewModel: viewModel))
    }

    private func presentPasswordConfirmationView(viewModel: RegisterVM) {
        navigationController?.push(RegisterConfirmPasswordView(viewModel: viewModel))
    }

    private func presentRegisteredSuccessfully() {

    }
}
