//
//  CantorCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import FinanceCoreData
import UIKit

final class CantorCoordinator: RootCoordinator {

    enum Destination {
        case exchangeRateList(for: CurrencyEntity)
    }

    private let navigationController = UINavigationController()

    func start() -> UIViewController {
        let viewModel = CantorVM(coordinator: self)
        let view = CantorView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view.environment(\.managedObjectContext, AppVM.shared.context))
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return navigationController
    }

    private func navigate(to destination: Destination) {
        switch destination {
        case let .exchangeRateList(currencyEntity):
            navigationController.push(ViewControllerProvider.exchangeRateList(for: currencyEntity))
        }
    }
}
