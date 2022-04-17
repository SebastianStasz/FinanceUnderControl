//
//  CurrenciesProvider.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 05/12/2021.
//

import Combine
import FinanceCoreData
import SwiftUI

final class CurrenciesProvider {

    struct Input {
        let searchText: AnyPublisher<String, Never>
    }

    struct Output {
        let currencies: AnyPublisher<FetchRequest<CurrencyEntity>, Never>
    }

    func transform(input: Input) -> Output {
        let currencies = input.searchText
            .map { text in
                text.isEmpty
                    ? CurrencyEntity.fetchRequest(sortingBy: [.byCode(.forward)])
                    : CurrencyEntity.fetchRequest(filteringBy: [.codeContains(text)], sortingBy: [.byCode(.forward)])
            }

        return Output(
            currencies: currencies.eraseToAnyPublisher()
        )
    }
}

extension CurrenciesProvider {

    static var primaryCurrencyCode: String? {
        UserDefaults.string(forKey: .primaryCurrency)
    }

    static var secondaryCurrencyCode: String? {
        UserDefaults.string(forKey: .secondaryCurrency)
    }
}
