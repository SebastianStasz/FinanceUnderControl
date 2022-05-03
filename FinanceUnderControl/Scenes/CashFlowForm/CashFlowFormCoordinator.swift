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

    private let formType: CashFlowFormType<CashFlowEntity>

    init(_ presentationStyle: PresentationStyle, formType: CashFlowFormType<CashFlowEntity>) {
        self.formType = formType
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = CashFlowFormVM(for: formType, coordinator: self)
        let view = CashFlowFormView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        viewController.addCloseButton()

//        viewModel.binding.createdSuccessfully
//            .sink { viewController.dismiss(animated: true) }
//            .store(in: &viewModel.cancellables)

        return viewController
    }
}
