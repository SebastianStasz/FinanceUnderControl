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
        case settings
        case topExpenses(HorizontalBarVD)
    }

    private let navigationController = UINavigationController()

    func start() -> UIViewController {
        let viewModel = DashboardVM(coordinator: self)
        let view = DashboardView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0, viewController: viewController) }
            .store(in: &viewModel.cancellables)

        return navigationController
    }

    private func navigate(to destination: Destination, viewController: UIViewController) {
        switch destination {
        case .settings:
            SettingsCoordinator(.presentFullScreen(on: navigationController)).start()
        case let .topExpenses(viewData):
            let vc = UIHostingController(rootView: ExpensesByCategoryView(viewData: viewData))
            navigationController.presentModally(vc)
        }
    }
}
