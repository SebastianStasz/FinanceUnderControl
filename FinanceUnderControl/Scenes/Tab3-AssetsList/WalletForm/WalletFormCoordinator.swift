//
//  WalletFormCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/06/2022.
//

import UIKit
import Shared

final class WalletFormCoordinator: Coordinator {

    enum Destination {
        case askToDismiss
        case dismiss
    }

    private let formType: WalletFormType

    init(_ presentationStyle: PresentationStyle, formType: WalletFormType) {
        self.formType = formType
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = WalletFormVM(formType: formType, coordinator: self)
        let viewController = ViewControllerProvider.walletForm(viewModel: viewModel)

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return viewController
    }
}

private extension WalletFormCoordinator {

    func navigate(to destination: Destination) {
        switch destination {
        case .askToDismiss:
            navigationController?.askToDismiss()
        case .dismiss:
            navigationController?.dismiss(animated: true)
        }
    }
}

