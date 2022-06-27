//
//  AuthenticationCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import FirebaseAuth
import UIKit

final class AuthenticationCoordinator: RootCoordinator {

    enum Destination {
        case didTapSignUp
        case loginError(AuthErrorCode.Code)
    }

    private weak var navigationController: UINavigationController?

    func start() -> UIViewController {
        let viewModel = LoginVM(coordinator: self)
        let viewController = SwiftUIVC(viewModel: viewModel, view: LoginView(viewModel: viewModel))
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewController.cancellables)

        self.navigationController = navigationController
        return navigationController
    }

    private func navigate(to destination: Destination) {
        switch destination {
        case .didTapSignUp:
            RegisterCoordinator(.presentFullScreen(on: navigationController)).start()
        case let .loginError(authErrorCode):
            handleLoginEror(authErrorCode)
        }
    }

    private func handleLoginEror(_ error: AuthErrorCode.Code) {
        let resultData = ResultData.error(title: "Failed to login", message: "Something went wrong. Please try again in a moment.")
        navigationController?.presentResultView(viewData: resultData)
    }
}
