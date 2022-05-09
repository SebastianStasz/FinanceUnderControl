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

    private let formType: FormType

    init(_ presentationStyle: PresentationStyle, formType: FormType) {
        self.formType = formType
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = CashFlowCategoryFormVM(for: formType, coordinator: self)
        let view = CashFlowCategoryFormView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.addCloseButton()
        return viewController
    }
}
