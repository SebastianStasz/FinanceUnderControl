//
//  CurrencyListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import Combine
import FinanceCoreData
import Foundation
import SwiftUI

final class CurrencyListVM: ObservableObject {

    struct Input {
        let selectCurrency = PassthroughSubject<CurrencyEntity, Never>()
    }

    @Published private(set) var currencies: FetchRequest<CurrencyEntity>
    @Published var exchageRateListVM: ExchangeRateListVM?
    @Published var searchText = ""
    let input = Input()

    init() {
        currencies = CurrencyEntity.fetchRequest(sortingBy: [.byCode(.forward)])

        input.selectCurrency
            .map { ExchangeRateListVM(currencyEntity: $0) }
            .assign(to: &$exchageRateListVM)

        ValidationHelper.search($searchText)
            .map { text in
                text.isEmpty
                    ? CurrencyEntity.fetchRequest(sortingBy: [.byCode(.forward)])
                    : CurrencyEntity.fetchRequest(filteringBy: [.codeContains(text), .nameContains(text)], sortingBy: [.byCode(.forward)])
            }
            .assign(to: &$currencies)
    }
}
