//
//  SettingsCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import UIKit

final class SettingsCoordinator: RootCoordinator {

    private let navigationController = UINavigationController()

    init() {
        navigationController.prefersLargeTitles()
    }

    func start() -> UIViewController {
        let viewModel = SettingsVM(coordinator: self)
        let view = SettingsView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}
