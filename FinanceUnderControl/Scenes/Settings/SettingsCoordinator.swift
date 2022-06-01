//
//  SettingsCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import UIKit
import Shared

final class SettingsCoordinator: Coordinator {

    enum Destination {
    }

    override func initializeView() -> UIViewController {
        let viewModel = SettingsVM(coordinator: self)
        let view = SettingsView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.addCloseButton()

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return viewController
    }

    private func navigate(to destination: Destination) {
        guard let navigationController = navigationController else { return }
    }
}