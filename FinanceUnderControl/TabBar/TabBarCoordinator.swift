//
//  TabBarCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/04/2022.
//

import UIKit

final class TabBarCoordinator: RootCoordinator {
    
    private weak var tabBarController: TabBarController?

    func start() -> UIViewController {
        let viewModel = TabBarVM(coordinator: self)
        let tabBarController = TabBarController(viewModel: viewModel)

        viewModel.binding.presentCashFlowTypeSelection
            .sink { [weak self] tab in self?.presentCashFlowTypeSelection() }
            .store(in: &viewModel.cancellables)

        self.tabBarController = tabBarController
        return tabBarController
    }

    private func presentCashFlowTypeSelection() {
        let alert = UIAlertController(title: .common_add, message: nil, preferredStyle: .actionSheet)
        alert.addAction(title: .common_expense, action: onSelf { $0.presentCashFlowForm(for: .new(.expense)) })
        alert.addAction(title: .common_income, action: onSelf { $0.presentCashFlowForm(for: .new(.income)) })
        alert.addCancelAction()
        tabBarController?.present(alert, animated: true)
    }

    private func presentCashFlowForm(for formType: CashFlowFormType<CashFlow>) {
        CashFlowFormCoordinator(.presentModally(on: tabBarController), formType: formType).start()
    }
}
