//
//  TabBarCoordinator.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 28/04/2022.
//

import UIKit
import SwiftUI
import Shared

final class TabBarCoordinator: RootCoordinator {
    
    private let tabBarController = AppTabBarController()

    func start() -> UIViewController {
        return tabBarController
    }
}

final class AppTabBarController: UITabBarController, CoordinatorProtocol {

    private lazy var viewModel = TabBarVM(coordinator: self)

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.binding.didSelectTab
            .sink { [weak self] tab in self?.selectedIndex = tab.id }
            .store(in: &viewModel.cancellables)

        let dashboard = DashboardCoordinator().start()
        let cashFlowList = CashFlowListCoordinator().start()
        let cantor = CantorCoordinator().start()
        let settings = SettingsCoordinator().start()

        viewControllers = [dashboard, cashFlowList, cantor, settings]

        let tabBarView = UIHostingController(rootView: TabBarView(viewModel: viewModel))

        tabBarView.view.frame = tabBar.frame
        view.addSubview(tabBarView.view)
    }
}
