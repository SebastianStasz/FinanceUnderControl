//
//  AssetsListCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import UIKit

final class AssetsListCoordinator: RootCoordinator {

    enum Destination {
        case addAssetSelection
        case walletEditForm(Wallet)
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
        case let .walletEditForm(wallet):
            presentWalletForm(for: .edit(wallet))
        case .addAssetSelection:
            presentAddAssetSelection()
        }
    }

    func presentAddAssetSelection() {
        let alert = UIAlertController(title: .common_add, message: nil, preferredStyle: .actionSheet)
        alert.addAction(title: "Wallet", action: onSelf { $0.presentWalletForm(for: .new()) })
        alert.addCancelAction()
        navigationController.present(alert, animated: true)
    }

    func presentWalletForm(for formType: WalletFormType) {
        WalletFormCoordinator(.presentModally(on: navigationController), formType: formType).start()
    }
}
