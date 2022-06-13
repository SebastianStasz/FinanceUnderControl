//
//  AssetsListCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import UIKit

final class AssetsListCoordinator: RootCoordinator {

    private let navigationController = UINavigationController()

    func start() -> UIViewController {
        let viewModel = AssetsListVM(coordinator: self)
        let view = AssetsListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]

        return navigationController
    }
}
