//
//  RegisterCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Combine
import FirebaseAuth
import Shared
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

        viewModel.binding.registeredSuccessfully
            .sink { [weak self] in self?.presentRegisteredSuccessfully() }
            .store(in: &viewController.cancellables)

        viewModel.binding.registrationError
            .sink { [weak self] in self?.handleRegistrationError($0) }
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
        let viewData = ResultVD.success(message: "Registered successfully") { [weak self] in
            self?.dismiss()
        }
        navigationController?.presentResultView(viewData: viewData)
        dismiss()
    }

    private func handleRegistrationError(_ error: AuthErrorCode) {
        let viewData: ResultVD
        let dismiss = onSelf { $0.dismiss() }
        switch error {
        case .emailAlreadyInUse:
            viewData = .error(message: "Provided email is already in use.", action: dismiss)
        default:
            viewData = .error(message: "Unknown error", action: dismiss)
        }
        navigationController?.presentResultView(viewData: viewData)
    }
}
