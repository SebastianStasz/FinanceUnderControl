//
//  TabBarController.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/05/2022.
//

import Shared
import SwiftUI

final class TabBarController: UITabBarController, UITabBarControllerDelegate {

    private let viewModel: TabBarVM

    init(viewModel: TabBarVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()

        let dashboardVC = DashboardCoordinator().start()
        let cashFlowListVC = CashFlowListCoordinator().start()
        let addCashFlows = UIViewController()
        let walletsListVM = AssetsListCoordinator().start()
        let cashFlowGroupingListVC = CashFlowGroupingCoordinator().start()

        dashboardVC.setTabBarItem(title: .tab_dashboard_title, icon: .dashboardTab, tag: 0)
        cashFlowListVC.setTabBarItem(title: .tab_cashFlow_title, icon: .cashFlowTab, tag: 1)
        addCashFlows.setTabBarItem(title: nil, icon: .plus, tag: 2)
        walletsListVM.setTabBarItem(title: .tab_assets_title, icon: .walletsTab, tag: 3)
        cashFlowGroupingListVC.setTabBarItem(title: .common_categories, icon: .cashFlowGroupingTab, tag: 4)

        viewControllers = [dashboardVC, cashFlowListVC, addCashFlows, walletsListVM, cashFlowGroupingListVC]
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 2 { viewModel.binding.presentCashFlowTypeSelection.send() }
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController), index != 2 else { return false }
        return true
    }
}
