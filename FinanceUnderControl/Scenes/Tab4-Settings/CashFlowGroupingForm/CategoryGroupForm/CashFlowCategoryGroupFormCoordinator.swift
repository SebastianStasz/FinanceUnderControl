//
//  CashFlowCategoryGroupFormCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/05/2022.
//

import UIKit
import Shared

final class CashFlowCategoryGroupFormCoordinator: Coordinator {
    typealias FormType = CashFlowFormType<CashFlowCategoryGroup>

    enum Destination {
        case createdSuccessfully
    }

    private let formType: FormType

    init(_ presentationStyle: PresentationStyle, formType: FormType) {
        self.formType = formType
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = CashFlowCategoryGroupFormVM(for: formType, coordinator: self)
        let view = CashFlowCategoryGroupFormView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.addCloseButton()

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)
        
        return viewController
    }
}

private extension CashFlowCategoryGroupFormCoordinator {

    func navigate(to destination: Destination) {
        switch destination {
        case .createdSuccessfully:
            navigationController?.dismiss(animated: true)
        }
    }
}
