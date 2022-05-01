//
//  DashboardCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/04/2022.
//

import SwiftUI

final class DashboardCoordinator: RootCoordinator {

    func start() -> UIViewController {
        let viewModel = DashboardVM(coordinator: self)
        let view = DashboardView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        return viewController
    }
}
