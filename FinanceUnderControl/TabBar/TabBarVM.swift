//
//  TabBarVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import Foundation
import FinanceCoreData
import Shared
import SSUtils

final class TabBarVM: ViewModel2 {

    struct ViewBinding {
        let didSelectTab = DriverSubject<TabBarModel>()
    }

    let binding = ViewBinding()
    @Published var selectedTab: TabBarModel = .dashboard
    @Published var arePopupsShown = false
    @Published var cashFlowCategoryType: CashFlowType?

    override func commonInit() {
        binding.didSelectTab.assign(to: &$selectedTab)
    }
}
