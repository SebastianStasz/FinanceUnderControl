//
//  CantorVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Combine
import FinanceCoreData
import SSValidation

final class CantorVM: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let currencySettings = CurrencySettings()

    @Published var currencySelector = CurrencySelector<CurrencyEntity?>()
    @Published var amountOfMoneyInput = Input<NumberInputSettings>(settings: .init(canBeEmpty: true))
    @Published private(set) var exchangeRateValue: String?
    @Published private(set) var exchangedMoney: String?

    var isExchangeRateData: Bool {
        guard let secondaryCurrencyCode = currencySelector.secondaryCurrency?.code,
              let primaryCurrency = currencySelector.primaryCurrency
        else { return false }
        return primaryCurrency.exchangeRates.contains(where: { $0.code == secondaryCurrencyCode })
    }

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

        let exchangeRateValue = $currencySelector
            .map { selector -> Double? in
                guard let primary = selector.primaryCurrency, let secondary = selector.secondaryCurrency else { return nil }
                guard let exchangeRateValue = primary.getExchangeRate(for: secondary.code)?.rateValue else {
                    return nil
                }
                return exchangeRateValue
            }

        Publishers.CombineLatest($currencySelector, exchangeRateValue)
            .map { values -> String? in
                guard let primary = values.0.primaryCurrency,
                      let secondary = values.0.secondaryCurrency,
                      let rateValue = values.1
                else { return nil }
                return "1 \(primary.code) = \(rateValue.asString(roundToDecimalPlaces: 2)) \(secondary.code)"
            }
            .assign(to: &$exchangeRateValue)

        Publishers.CombineLatest3(exchangeRateValue, $amountOfMoneyInput, $currencySelector)
            .map { values -> String? in
                guard let primary = values.2.primaryCurrency,
                      let secondary = values.2.secondaryCurrency,
                      let rateValue = values.0,
                      let amount = values.1.value,
                      amount != 0
                else { return nil }
                let result = (rateValue * amount).asString(roundToDecimalPlaces: 2)
                return "\(amount.asString) \(primary.code) = \(result) \(secondary.code)"
            }
            .assign(to: &$exchangedMoney)
    }

//    func tryToSetCurr /
}
