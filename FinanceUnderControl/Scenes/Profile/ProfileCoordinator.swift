//
//  ProfileCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 26/06/2022.
//

import UIKit

final class ProfileCoordinator: Coordinator {

    enum Destination {
        case dismiss
    }

    override func initializeView() -> UIViewController {
        let viewModel = ProfileVM(coordinator: self)
        let view = ProfileView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return viewController
    }

    private func navigate(to destination: Destination) {
        switch destination {
        case .dismiss:
            navigationController?.dismiss(animated: true)
        }
    }
}
