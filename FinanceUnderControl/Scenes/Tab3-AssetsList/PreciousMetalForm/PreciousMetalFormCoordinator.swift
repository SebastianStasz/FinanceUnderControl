//
//  PreciousMetalFormCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import UIKit

final class PreciousMetalFormCoordinator: Coordinator {

    enum Destination {
    }

    private let formType: PreciousMetalFormType

    init(_ presentationStyle: PresentationStyle, formType: PreciousMetalFormType) {
        self.formType = formType
        super.init(presentationStyle)
    }

    override func initializeView() -> UIViewController {
        let viewModel = PreciousMetalFormVM(formType: formType, coordinator: self)
        let viewController = ViewControllerProvider.preciousMetalForm(viewModel: viewModel)

        viewModel.binding.navigateTo
            .sink { [weak self] in self?.navigate(to: $0) }
            .store(in: &viewModel.cancellables)

        return viewController
    }
}

private extension PreciousMetalFormCoordinator {

    func navigate(to destination: Destination) {
    }
}
