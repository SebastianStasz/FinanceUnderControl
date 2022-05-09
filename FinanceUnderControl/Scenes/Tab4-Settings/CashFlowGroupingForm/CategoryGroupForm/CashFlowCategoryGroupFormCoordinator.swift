//
//  CashFlowCategoryGroupFormCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/05/2022.
//

import UIKit
import Shared

final class CashFlowCategoryGroupFormCoordinator: Coordinator {

    private let type: CashFlowType

    init(_ presentationStyle: PresentationStyle, type: CashFlowType) {
        self.type = type
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = CashFlowCategoryGroupFormVM(for: type, coordinator: self)
        let view = CashFlowCategoryGroupFormView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.addCloseButton()
        return viewController
    }
}
