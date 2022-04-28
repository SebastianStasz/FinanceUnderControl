//
//  AuthenticationCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import FirebaseAuth
import UIKit

final class AuthenticationCoordinator: Coordinator {

    override func initializeView() -> UIViewController {
        let viewModel = LoginVM(coordinator: self)
        let viewController = SwiftUIVC(viewModel: viewModel, view: LoginView(viewModel: viewModel))

        viewModel.binding.didTapSignUp
            .sink { [weak self] in self?.presentRegisterView() }
            .store(in: &viewController.cancellables)

        viewModel.binding.loginError
            .sink { [weak self] in self?.handleLoginEror($0) }
            .store(in: &viewController.cancellables)

        return viewController
    }

    private func presentRegisterView() {
        guard let navigationController = navigationController else { return }
        RegisterCoordinator(.presentFullScreen(on: navigationController)).start()
    }

    private func handleLoginEror(_ error: AuthErrorCode) {
        let resultData = ResultData.error(title: "Failed to login", message: "Something went wrong. Please try again in a moment.")
        navigationController?.presentResultView(viewData: resultData)
    }
}
