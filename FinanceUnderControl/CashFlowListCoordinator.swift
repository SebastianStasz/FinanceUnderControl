//
//  CashFlowListCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/04/2022.
//

import SwiftUI

final class CashFlowListCoordinator: RootCoordinator {

    func start() -> UIViewController {
        let viewModel = CashFlowListVM(coordinator: self)
        let view = CashFlowListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        return viewController
    }
}
