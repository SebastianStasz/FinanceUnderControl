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
    }

    private let navigationController = UINavigationController()
    @Published private var cashFlowFilter = CashFlowFilter()

    init() {
        navigationController.prefersLargeTitles()
    }

    func start() -> UIViewController {
        let viewModel = CashFlowListVM(coordinator: self)
        let view = CashFlowListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return navigationController
    }

    private func navigate(to destination: Destination) {
        switch destination {
        case .filterView:
            let viewModel = CashFlowFilterVM(filter: cashFlowFilter)
            let view = CashFlowFilterView(viewModel: viewModel)
            let viewController = SwiftUIVC(viewModel: viewModel, view: view)
            navigationController.presentModally(viewController)
        }
    }
}
