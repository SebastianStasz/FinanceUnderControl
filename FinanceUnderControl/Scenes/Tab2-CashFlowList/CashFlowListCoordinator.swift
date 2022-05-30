//
//  CashFlowListCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 29/04/2022.
//

import SwiftUI
import Shared

final class CashFlowListCoordinator: RootCoordinator {

    enum Destination {
        case filterView
        case editForm(for: CashFlow)
    }

    private let navigationController = UINavigationController()

    func start() -> UIViewController {
        let cashFlowFilterVM = CashFlowFilterVM()
        let viewModel = CashFlowListVM(coordinator: self, cashFlowFilterVM: cashFlowFilterVM)
        let view = CashFlowListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0, cashFlowFilterVM: cashFlowFilterVM) }
            .store(in: &viewModel.cancellables)

        return navigationController
    }
}

private extension CashFlowListCoordinator {

    func navigate(to destination: Destination, cashFlowFilterVM: CashFlowFilterVM) {
        switch destination {
        case .filterView:
            presentFilterView(viewModel: cashFlowFilterVM)
        case let .editForm(cashFlow):
            presentEditForm(for: cashFlow)
        }
    }

    func presentFilterView(viewModel: CashFlowFilterVM) {
        let viewController = ViewControllerProvider.cashFlowFilterVC(viewModel: viewModel)
        navigationController.presentModally(viewController)
    }

    func presentEditForm(for cashFlow: CashFlow) {
        CashFlowFormCoordinator(.presentModally(on: navigationController), formType: .edit(cashFlow)).start()
    }
}
