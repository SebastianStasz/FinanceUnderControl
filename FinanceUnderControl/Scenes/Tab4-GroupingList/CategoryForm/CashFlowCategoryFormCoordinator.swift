//
//  CashFlowCategoryFormCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/05/2022.
//

import UIKit
import Shared

final class CashFlowCategoryFormCoordinator: Coordinator {
    typealias FormType = CashFlowFormType<CashFlowCategory>

    enum Destination {
        case dismiss
        case askToDismiss
    }

    private let formType: FormType

    init(_ presentationStyle: PresentationStyle, formType: FormType) {
        self.formType = formType
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = CashFlowCategoryFormVM(for: formType, coordinator: self)
        let view = CashFlowCategoryFormView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return viewController
    }
}

private extension CashFlowCategoryFormCoordinator {

    func navigate(to destination: Destination) {
        switch destination {
        case .askToDismiss:
            navigationController?.askToDismiss()
        case .dismiss:
            navigationController?.dismiss(animated: true)
        }
    }
}
