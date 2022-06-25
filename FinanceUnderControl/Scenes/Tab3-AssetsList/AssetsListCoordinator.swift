//
//  AssetsListCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import UIKit
import Shared

final class AssetsListCoordinator: RootCoordinator {

    enum Destination {
        case addAssetSelection
        case assetEditForm(Asset)
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
        case let .assetEditForm(asset):
            presentAssetEditForm(for: asset)
        case .addAssetSelection:
            presentAddAssetSelection()
        }
    }

    func presentAddAssetSelection() {
        let alert = UIAlertController(title: .common_add, message: nil, preferredStyle: .actionSheet)
        alert.addAction(title: .asset_wallet, action: onSelf { $0.presentWalletForm(for: .new()) })
        alert.addAction(title: .asset_precious_metal, action: onSelf { $0.presentPreciousMetalForm(for: .new()) })
        alert.addCancelAction()
        navigationController.present(alert, animated: true)
    }

    func presentAssetEditForm(for asset: Asset) {
        switch asset {
        case let .wallet(wallet, _):
            presentWalletForm(for: .edit(wallet))
        case let .preciousMetal(preciousMetal, _):
            presentPreciousMetalForm(for: .edit(preciousMetal))
        }
    }

    func presentWalletForm(for formType: WalletFormType) {
        WalletFormCoordinator(.presentModally(on: navigationController), formType: formType).start()
    }

    func presentPreciousMetalForm(for formType: PreciousMetalFormType) {
        PreciousMetalFormCoordinator(.presentModally(on: navigationController), formType: formType).start()
    }
}
