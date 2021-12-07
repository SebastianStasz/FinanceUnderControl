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

    @Published var primaryCurrency: CurrencyEntity?
    @Published var secondaryCurrency: CurrencyEntity?
    @Published private(set) var exchangeRateValue: String?

    init() {
        Publishers.CombineLatest($primaryCurrency, $secondaryCurrency)
            .compactMap { primary, secondary -> String? in
                guard let primary = primary, let secondary = secondary else { return nil }
                guard let exchangeRateValue = primary.getExchangeRate(for: secondary.code)?.rateValue else {
                    return nil
                }
                return "1 \(primary.code) = \(exchangeRateValue.asString(roundToDecimalPlaces: 2)) \(secondary.code)"
            }
            .assign(to: &$exchangeRateValue)
    }
}
