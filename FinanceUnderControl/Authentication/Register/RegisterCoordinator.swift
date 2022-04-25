//
//  RegisterCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/04/2022.
//

import Combine
import SwiftUI

final class RegisterCoordinator: Coordinator {

    private let viewModel = RegisterVM()
    private var cancellables: Set<AnyCancellable> = []
    let navigationController = UINavigationController()

    init() {
        let view = RegisterEmailView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.addCloseButton()

        navigationController.viewControllers = [viewController]

        viewModel.binding.didConfirmEmail
            .sink { [weak self] in self?.presentPasswordView() }
            .store(in: &cancellables)

        viewModel.binding.didEnterPassword
            .sink { [weak self] in self?.presentPasswordConfirmationView() }
            .store(in: &cancellables)
    }

    private func presentPasswordView() {
        navigationController.push(RegisterPasswordView(viewModel: viewModel))
    }

    private func presentPasswordConfirmationView() {
        navigationController.push(RegisterConfirmPasswordView(viewModel: viewModel))
    }

    private func presentRegisteredSuccessfully() {

    }
}
