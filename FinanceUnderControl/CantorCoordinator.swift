//
//  CantorCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import UIKit

final class CantorCoordinator: RootCoordinator {

    func start() -> UIViewController {
        let viewModel = CantorVM(coordinator: self)
        let view = CantorView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)
        return viewController
    }
}
