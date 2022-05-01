//
//  TabBarCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/04/2022.
//

import UIKit
import Shared
import SwiftUI

final class TabBarCoordinator: RootCoordinator {
    
    private var tabBarController: AppTabBarController!

    func start() -> UIViewController {
        let viewModel = TabBarVM(coordinator: self)
        tabBarController = AppTabBarController(viewModel: viewModel)

        viewModel.binding.didSelectTab
            .sink { [weak self] tab in self?.tabBarController.selectedIndex = tab.id }
            .store(in: &viewModel.cancellables)

        viewModel.binding.presentCashFlowTypeSelection
            .sink { [weak self] tab in
                self?.presentCashFlowTypeSelection() }
            .store(in: &viewModel.cancellables)

        return tabBarController
    }

    private func presentCashFlowTypeSelection() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(title: "Expense", action: onSelf { $0.presentCashFlowForm(for: .expense) })
        alert.addAction(title: "Income", action: onSelf { $0.presentCashFlowForm(for: .income) })
        alert.addCancelAction()
        tabBarController.present(alert, animated: true)
    }

    private func presentCashFlowForm(for type: CashFlowType) {
        let viewController = UIHostingController(rootView: CashFlowFormView(for: .new(for: type)))
        tabBarController.present(viewController, animated: true)
    }
}
