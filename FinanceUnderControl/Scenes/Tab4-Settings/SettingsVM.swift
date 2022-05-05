//
//  SettingsVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 10/12/2021.
//

import Combine
import Foundation
import FinanceCoreData
import Shared

final class SettingsVM: ViewModel {

    @Published var currencySelector = CurrencySelector<Currency?>(primaryCurrency: PersistentStorage.primaryCurrency, secondaryCurrency: PersistentStorage.secondaryCurrency)

    override func viewDidLoad() {
        $currencySelector
            .sinkAndStore(on: self, action: { vm, selector in
                UserDefaults.set(value: selector.primaryCurrency!.code, forKey: .primaryCurrency)
                UserDefaults.set(value: selector.secondaryCurrency!.code, forKey: .secondaryCurrency)
            })
    }
}
