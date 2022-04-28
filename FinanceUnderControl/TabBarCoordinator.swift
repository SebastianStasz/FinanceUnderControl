//
//  TabBarCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/04/2022.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    override func initializeView() -> UIViewController {
        let viewModel = TabBarVM(coordinator: self)
        let view = TabBarView(viewModel: viewModel)
        let viewController = SwiftUIVC(viewModel: viewModel, view: view)

        return viewController
    }
}
