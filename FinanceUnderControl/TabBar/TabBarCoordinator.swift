//
//  TabBarCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/04/2022.
//

import Shared
import SwiftUI

final class TabBarCoordinator: RootCoordinator {
    
    private var tabBarController: TabBarController!
    private var cashFlowFormVM: CashFlowFormVM?

    func start() -> UIViewController {
        let viewModel = TabBarVM(coordinator: self)
        tabBarController = TabBarController(viewModel: viewModel)

        viewModel.binding.didSelectTab
            .sink { [weak self] tab in self?.tabBarController.selectedIndex = tab.id }
            .store(in: &viewModel.cancellables)

        viewModel.binding.presentCashFlowTypeSelection
            .sink { [weak self] tab in self?.presentCashFlowTypeSelection() }
            .store(in: &viewModel.cancellables)

        return tabBarController
    }

    private func presentCashFlowTypeSelection() {
        let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .actionSheet)
        alert.addAction(title: "Expense", action: onSelf { $0.presentCashFlowForm(for: .expense) })
        alert.addAction(title: "Income", action: onSelf { $0.presentCashFlowForm(for: .income) })
        alert.addCancelAction()
        tabBarController.present(alert, animated: true)
    }

    private func presentCashFlowForm(for type: CashFlowType) {
        let viewModel = CashFlowFormVM(for: type)
        cashFlowFormVM = viewModel
        let view = CashFlowFormView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        tabBarController.present(viewController, animated: true)
    }
}
