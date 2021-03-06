//
//  CantorVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import Combine
import FinanceCoreData
import Shared
import SwiftUI
import SSUtils
import SSValidation

final class CantorVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<CantorCoordinator.Destination>()
    }

    @Published var currencySelector = CurrencySelector<CurrencyEntity?>(primaryCurrency: nil, secondaryCurrency: nil)
    let amountOfMoneyInput = DecimalInputVM(validator: .alwaysValid)
    @Published private(set) var exchangeRateValue: String?
    @Published private(set) var exchangedMoney: String?
    let binding = Binding()

    var isFormFilled: Bool {
        guard currencySelector.secondaryCurrency.notNil,
              currencySelector.primaryCurrency.notNil
        else { return false }
        return true
    }

    override func viewDidLoad() {
        currencySelector.setPrimaryCurrency(to: CurrencyEntity.get(withCode: PersistentStorage.primaryCurrency.code, from: AppVM.shared.context))
        currencySelector.setSecondaryCurrency(to: CurrencyEntity.get(withCode: PersistentStorage.secondaryCurrency.code, from: AppVM.shared.context))

        let exchangeRateValue = $currencySelector
            .map { selector -> Decimal? in
                guard let primary = selector.primaryCurrency, let secondary = selector.secondaryCurrency else { return nil }
                guard let exchangeRateValue = primary.getExchangeRate(for: secondary.code)?.rateValue else {
                    return nil
                }
                return exchangeRateValue
            }

        CombineLatest($currencySelector, exchangeRateValue)
            .map { values -> String? in
                guard let primary = values.0.primaryCurrency,
                      let secondary = values.0.secondaryCurrency,
                      let rateValue = values.1, rateValue > 0
                else { return nil }
                return "1 \(primary.code) = \(rateValue.asString) \(secondary.code)"
            }
            .assign(to: &$exchangeRateValue)

        CombineLatest3(exchangeRateValue, amountOfMoneyInput.result(), $currencySelector)
            .map { values -> String? in
                guard let primary = values.2.primaryCurrency,
                      let secondary = values.2.secondaryCurrency,
                      let rateValue = values.0,
                      let amount = values.1,
                      amount != 0
                else { return nil }
                let result = (rateValue * amount).formatted(for: Currency(rawValue: secondary.code)!)
                return "\(amount.asString) \(primary.code) = \(result) \(secondary.code)"
            }
            .sink { [weak self] value in
                withAnimation(.easeInOut) {
                    self?.exchangedMoney = value
                }
            }
            .store(in: &cancellables)
    }
}
