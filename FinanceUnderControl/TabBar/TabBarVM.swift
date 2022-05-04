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

final class TabBarVM: ViewModel {

    private let currencyService = CurrencyService()

    struct ViewBinding {
        let didSelectTab = DriverSubject<TabBarModel>()
        let presentCashFlowTypeSelection = DriverSubject<Void>()
    }

    let binding = ViewBinding()
    @Published private(set) var selectedTab: TabBarModel = .dashboard
    @Published var arePopupsShown = false

    override func commonInit() {
        binding.didSelectTab.assign(to: &$selectedTab)
    }

    func setupCurrencies() async {
        await currencyService.setupCurrencies(in: AppVM.shared.context)
    }
}
