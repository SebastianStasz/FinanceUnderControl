//
//  WalletsListCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import UIKit

final class WalletsListCoordinator: RootCoordinator {

    private let navigationController = UINavigationController()

    func start() -> UIViewController {
        let viewModel = WalletsListVM(coordinator: self)
        let view = WalletsListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]

        return navigationController
    }
}
