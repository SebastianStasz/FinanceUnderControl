//
//  DashboardCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/04/2022.
//

import SwiftUI
import Shared

final class DashboardCoordinator: RootCoordinator {

    enum Destination {
        case profile
        case settings
        case topExpenses(HorizontalBarVD)
    }

    private weak var navigationController: UINavigationController?

    func start() -> UIViewController {
        let viewModel = DashboardVM(coordinator: self)
        let view = DashboardView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        self.navigationController = navigationController
        return navigationController
    }

    private func navigate(to destination: Destination) {
        switch destination {
        case .profile:
            ProfileCoordinator(.presentFullScreen(on: navigationController)).start()
        case .settings:
            SettingsCoordinator(.presentFullScreen(on: navigationController)).start()
        case let .topExpenses(viewData):
            let vc = UIHostingController(rootView: ExpensesByCategoryView(viewData: viewData))
            navigationController?.presentModally(vc)
        }
    }
}
