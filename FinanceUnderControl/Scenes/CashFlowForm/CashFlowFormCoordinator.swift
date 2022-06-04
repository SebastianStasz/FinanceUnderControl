//
//  CashFlowFormCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 03/05/2022.
//

import UIKit
import Shared
import FinanceCoreData

final class CashFlowFormCoordinator: Coordinator {
    typealias FormType = CashFlowFormType<CashFlow>

    enum Destination {
        case askToDismiss
        case dismiss
    }

    private let formType: FormType

    init(_ presentationStyle: PresentationStyle, formType: FormType) {
        self.formType = formType
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = CashFlowFormVM(for: formType, coordinator: self)
        let view = CashFlowFormView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return viewController
    }
}

private extension CashFlowFormCoordinator {

    func navigate(to destination: Destination) {
        switch destination {
        case .askToDismiss:
            askToDismiss()
        case .dismiss:
            dismissForm()
        }
    }

    func askToDismiss() {
        let alert = UIAlertController.actionSheet()
        alert.addAction(title: .common_discard_changes, style: .destructive, action: dismissForm)
        alert.addCancelAction()
        navigationController?.present(alert, animated: true)
    }

    func dismissForm() {
        navigationController?.dismiss(animated: true)
    }
}
