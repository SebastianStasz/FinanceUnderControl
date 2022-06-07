//
//  TabBarVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import Combine
import Foundation
import SSUtils

final class TabBarVM: ViewModel {

    private let currencyService = CurrencyService()
    var currencyCancellable: AnyCancellable? = nil

    struct ViewBinding {
        let presentCashFlowTypeSelection = DriverSubject<Void>()
    }

    let binding = ViewBinding()

    override func viewDidLoad() {
        currencyCancellable = Just(())
            .perform(on: self) { vm, _ in
                await vm.currencyService.setupCurrencies(in: AppVM.shared.context)
            }
            .sink { _ in }
    }
}
