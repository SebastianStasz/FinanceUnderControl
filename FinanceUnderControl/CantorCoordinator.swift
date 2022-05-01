//
//  CantorCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import UIKit

final class CantorCoordinator: RootCoordinator {

    private let navigationController = UINavigationController()

    init() {
        navigationController.prefersLargeTitles()
    }

    func start() -> UIViewController {
        let viewModel = CantorVM(coordinator: self)
        let view = CantorView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view.environment(\.managedObjectContext, AppVM.shared.context))
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}
