//
//  AssetsListCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import UIKit

final class AssetsListCoordinator: RootCoordinator {

    enum Destination {
        case walletForm(Wallet)
    }

    private let navigationController = UINavigationController()

    func start() -> UIViewController {
        let viewModel = AssetsListVM(coordinator: self)
        let view = AssetsListView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        navigationController.viewControllers = [viewController]

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return navigationController
    }
}

private extension AssetsListCoordinator {

    func navigate(to destination: Destination) {
        switch destination {
        case let .walletForm(wallet):
            presentWalletForm(for: wallet)
        }
    }

    func presentWalletForm(for wallet: Wallet) {
        let viewController = ViewControllerProvider.walletForm(for: wallet)
        navigationController.presentModally(viewController)
    }
}
