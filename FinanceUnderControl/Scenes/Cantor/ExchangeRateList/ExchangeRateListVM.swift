//
//  ExchangeRateListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 03/12/2021.
//

import Combine
import FinanceCoreData
import Foundation

final class ExchangeRateListVM: ObservableObject, Identifiable {
    private let currencyEntity: CurrencyEntity
    @Published private(set) var exchangeRates: [ExchangeRateEntity] = []
    @Published var searchText = ""

    var baseCurrencyCode: String {
        currencyEntity.code
    }

    init(currencyEntity: CurrencyEntity) {
        self.currencyEntity = currencyEntity
        exchangeRates = currencyEntity.exchangeRatesArray

        ValidationHelper.search($searchText)
            .map { text in
                text.isEmpty
                    ? currencyEntity.exchangeRatesArray
                    : currencyEntity.exchangeRatesArray.filter { $0.code.lowerCaseDiacriticInsensitive.contains(text) }
            }
            .assign(to: &$exchangeRates)
    }
}


