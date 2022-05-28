//
//  DashboardCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/04/2022.
//

import SwiftUI

final class DashboardCoordinator: RootCoordinator {

    enum Destination {
        case settings
    }

    func start() -> UIViewController {
        let viewModel = DashboardVM(coordinator: self)
        let view = DashboardView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0, viewController: viewController) }
            .store(in: &viewModel.cancellables)

        return viewController
    }

    private func navigate(to destination: Destination, viewController: UIViewController) {
        switch destination {
        case .settings:
            SettingsCoordinator(.presentFullScreen(on: viewController)).start()
        }
    }
}
