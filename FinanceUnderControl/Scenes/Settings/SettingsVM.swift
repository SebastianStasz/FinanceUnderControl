//
//  SettingsVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 10/12/2021.
//

import Foundation
import Shared
import SSUtils

final class SettingsVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<SettingsCoordinator.Destination>()
    }

    let binding = Binding()
    @Published var currencySelector = CurrencySelector<Currency>(primaryCurrency: PersistentStorage.primaryCurrency, secondaryCurrency: PersistentStorage.secondaryCurrency)
    @Published var appTheme = PersistentStorage.appTheme

    override func viewDidLoad() {
        $currencySelector.sinkAndStore(on: self, action: { vm, selector in
            UserDefaults.set(value: selector.primaryCurrency.code, forKey: .primaryCurrency)
            UserDefaults.set(value: selector.secondaryCurrency.code, forKey: .secondaryCurrency)
        })
        $appTheme.sinkAndStore(on: self) { _, theme in
            UserDefaults.set(value: theme.rawValue, forKey: .appTheme)
            AppVM.shared.binding.didChangeAppTheme.send()
        }
    }
}
