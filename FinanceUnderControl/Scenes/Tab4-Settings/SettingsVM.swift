//
//  SettingsVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 10/12/2021.
//

import Combine
import Foundation
import FinanceCoreData

final class SettingsVM: ViewModel2 {

    @Published private var currencySettings = CurrencySettings()

    @Published var primaryCurrency: CurrencyEntity?
    @Published var secondaryCurrency: CurrencyEntity?

    func bind() {
        let currencySettingsOutput = currencySettings.result()
        currencySettingsOutput.primaryCurrency.assign(to: &$primaryCurrency)
        currencySettingsOutput.secondaryCurrency.assign(to: &$secondaryCurrency)

        $primaryCurrency
            .compactMap { $0?.code }
            .sink { [weak self] code in
                guard self?.currencySettings.currencySelector.primaryCurrency != code else { return }
                self?.currencySettings.currencySelector.setPrimaryCurrency(to: code)
            }
            .store(in: &cancellables)

        $secondaryCurrency
            .compactMap { $0?.code }
            .sink { [weak self] code in
                guard self?.currencySettings.currencySelector.secondaryCurrency != code else { return }
                self?.currencySettings.currencySelector.setSecondaryCurrency(to: code)
            }
            .store(in: &cancellables)
    }
}
