//
//  CashFlowListCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/04/2022.
//

import SwiftUI
import Shared

final class CashFlowListCoordinator: RootCoordinator {

    private let navigationController = UINavigationController()

    init() {
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() -> UIViewController {
        let viewModel = CashFlowListVM(coordinator: self)
        let view = CashFlowListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]
        return navigationController
    }

    private func presentFilterView() {

    }
}
