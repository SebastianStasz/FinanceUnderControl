//
//  CurrencySelector.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 11/12/2021.
//

import Foundation
import FinanceCoreData

struct CurrencySelector<T: Equatable> {

    var primaryCurrency: T {
        didSet { if primaryCurrency == secondaryCurrency { secondaryCurrency = oldValue } }
    }
    var secondaryCurrency: T {
        didSet { if primaryCurrency == secondaryCurrency { primaryCurrency = oldValue } }
    }

    mutating func setPrimaryCurrency(to currency: T) {
        guard isCurrencyCode(currency) else { return }
        primaryCurrency = currency
    }

    mutating func setSecondaryCurrency(to currency: T) {
        guard isCurrencyCode(currency) else { return }
        secondaryCurrency = currency
    }

    private func isCurrencyCode(_ currency: T) -> Bool {
        if let code = currency as? String {
            // TODO: Provide better checking if code is real.
            return code.count == 3
        }
        return true
    }
}

extension CurrencySelector where T == CurrencyEntity? {
    init() {
        primaryCurrency = nil
        secondaryCurrency = nil
    }
}
