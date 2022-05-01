//
//  AppTabBarController.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import SwiftUI

final class AppTabBarController: UITabBarController {

    private let viewModel: TabBarVM

    init(viewModel: TabBarVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            DashboardCoordinator().start(),
            CashFlowListCoordinator().start(),
            CantorCoordinator().start(),
            SettingsCoordinator().start()
        ]

        UITabBar.appearance().isHidden = true
        let customTabBar = UIHostingController(rootView: TabBarView(viewModel: viewModel))
        view.addSubview(customTabBar.view)

        customTabBar.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTabBar.view.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.view.trailingAnchor.constraint(equalTo:tabBar.trailingAnchor),
            customTabBar.view.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
            customTabBar.view.topAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
    }
}
