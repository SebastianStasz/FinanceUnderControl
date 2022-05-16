//
//  RegisterCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import FirebaseAuth
import Shared
import SwiftUI

final class RegisterCoordinator: Coordinator {

    enum Destination {
        case didConfirmEmail
        case didEnterPassword
        case registeredSuccessfully
        case registrationError(AuthErrorCode)
    }

    override func initializeView() -> UIViewController {
        let viewModel = RegisterVM(coordinator: self)
        let view = RegisterEmailView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.addCloseButton()

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0, viewModel: viewModel) }
            .store(in: &viewController.cancellables)

        return viewController
    }
}

private extension RegisterCoordinator {

    func navigate(to destination: Destination, viewModel: RegisterVM) {
        switch destination {
        case .didConfirmEmail:
            navigationController?.push(RegisterPasswordView(viewModel: viewModel))
        case .didEnterPassword:
            navigationController?.push(RegisterConfirmPasswordView(viewModel: viewModel))
        case .registeredSuccessfully:
            presentRegisteredSuccessfully()
        case let .registrationError(authErrorCode):
            handleRegistrationError(authErrorCode)
        }
    }

    func presentRegisteredSuccessfully() {
        let viewData = ResultData.success(title: .authorization_register_success_title, message: .authorization_register_success_message, action: goBackToLoginView)
        navigationController?.presentResultView(viewData: viewData)
    }

    func handleRegistrationError(_ error: AuthErrorCode) {
        switch error {
        case .emailAlreadyInUse:
            presentEmailAlreadyInUse()
        case .invalidRecipientEmail, .missingEmail:
            presentInvalidEmail()
        default:
            presentGenericRegistrationError()
        }
    }

    func presentEmailAlreadyInUse() {
        let resultData = ResultData.error(title: .authorization_register_account_exists_title, message: .authorization_register_account_exists_message, action: goBackToLoginView)
        navigationController?.presentResultView(viewData: resultData)
    }

    func presentInvalidEmail() {
        let resultData = ResultData.error(title: .authorization_register_account_invalid_email_title, message: .authorization_register_account_invalid_email_message)
        let completion = onSelf { $0.navigationController?.popToView(ofType: RegisterEmailView.self, animated: true) }
        navigationController?.presentResultView(viewData: resultData, completion: completion)
    }

    func presentGenericRegistrationError() {
        let resultData = ResultData.error(title: .common_error, message: .authorization_register_account_unknown_error_message)
        navigationController?.presentResultView(viewData: resultData)
    }

    func goBackToLoginView() {
        navigationController?.presentingViewController?.dismiss(animated: true)
    }
}
