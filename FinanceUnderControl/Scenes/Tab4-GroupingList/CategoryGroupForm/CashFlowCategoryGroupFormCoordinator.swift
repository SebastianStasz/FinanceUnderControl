//
//  CashFlowCategoryGroupFormCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/05/2022.
//

import UIKit
import Shared
import SwiftUI

final class CashFlowCategoryGroupFormCoordinator: Coordinator {
    typealias FormType = CashFlowFormType<CashFlowCategoryGroup>

    enum Destination {
        case dismiss
        case manageCategories
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
            .sink { [weak self] in self?.navigate(to: $0, viewModel: viewModel) }
            .store(in: &viewModel.cancellables)
        
        return viewController
    }
}

private extension CashFlowCategoryGroupFormCoordinator {

    func navigate(to destination: Destination, viewModel: CashFlowCategoryGroupFormVM) {
        switch destination {
        case .dismiss:
            navigationController?.dismiss(animated: true)
        case .manageCategories:
            let view = ManageCategoriesView(viewModel: viewModel)
            let viewController = UIHostingController(rootView: view)
            navigationController?.push(viewController)
        }
    }
}
