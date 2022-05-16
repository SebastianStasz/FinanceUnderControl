//
//  SettingsCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import UIKit
import Shared

final class SettingsCoordinator: RootCoordinator {

    enum Destination {
        case cashFlowGroupForm(CashFlowType)
    }

    private let navigationController = UINavigationController()

    init() {
        navigationController.prefersLargeTitles()
    }

    func start() -> UIViewController {
        let viewModel = SettingsVM(coordinator: self)
        let view = SettingsView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return navigationController
    }

    private func navigate(to destination: Destination) {
        switch destination {
        case let .cashFlowGroupForm(type):
            CashFlowGroupingCoordinator(.push(on: navigationController), type: type).start()
        }
    }
}
