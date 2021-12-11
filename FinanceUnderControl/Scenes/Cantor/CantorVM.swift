//
//  CantorVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Combine
import FinanceCoreData
import Foundation
import SwiftUI

final class CantorVM: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let currencySettings = CurrencySettings()

    @Published var currencySelector = CurrencySelector<CurrencyEntity?>()
    @Published var amountOfMoney = ""
    @Published private(set) var exchangeRateValue: String?

    init() {
        let currencySettingsOutput = currencySettings.bind()
        currencySettingsOutput.primaryCurrency
            .sink { [weak self] currency in
                self?.currencySelector.setPrimaryCurrency(to: currency)
            }
            .store(in: &cancellables)

        currencySettingsOutput.secondaryCurrency
            .sink { [weak self] currency in
                self?.currencySelector.setSecondaryCurrency(to: currency)
            }
            .store(in: &cancellables)

        $currencySelector
            .compactMap { selector -> String? in
                guard let primary = selector.primaryCurrency, let secondary = selector.secondaryCurrency else { return nil }
                guard let exchangeRateValue = primary.getExchangeRate(for: secondary.code)?.rateValue else {
                    return nil
                }
                return "1 \(primary.code) = \(exchangeRateValue.asString(roundToDecimalPlaces: 2)) \(secondary.code)"
            }
            .assign(to: &$exchangeRateValue)
    }
}
