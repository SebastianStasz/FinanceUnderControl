//
//  AuthenticationCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Combine
import SwiftUI

final class AuthenticationCoordinator: Coordinator {

    private let viewModel = LoginVM()
    private var cancellables: Set<AnyCancellable> = []
    private var coordinators: [Coordinator] = []
    let rootViewController: UIViewController

    init() {
        let view = LoginView(viewModel: viewModel)
        rootViewController = UIHostingController(rootView: view)

        viewModel.viewBinding.didTapSignUp
            .sink { [weak self] in self?.presentRegisterView() }
            .store(in: &cancellables)
    }

    private func presentRegisterView() {
        let coordinator = RegisterCoordinator()
        let dismiss = {
            coordinators.fir
        }
        coordinators.append(coordinator)
        rootViewController.presentFullScreen(coordinator.navigationController)
    }
}

extension UIViewController {
    func presentFullScreen(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
