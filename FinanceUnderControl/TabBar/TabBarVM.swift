//
//  TabBarVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import Foundation
import SSUtils

final class TabBarVM: ViewModel {

    private let currencyService = CurrencyService()

    struct ViewBinding {
        let presentCashFlowTypeSelection = DriverSubject<Void>()
    }

    let binding = ViewBinding()

    func setupCurrencies() async {
        await currencyService.setupCurrencies(in: AppVM.shared.context)
    }
}
