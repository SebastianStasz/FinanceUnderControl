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

    private let currenciesProvider = CurrenciesProvider()

    @Published private(set) var currencies: FetchRequest<CurrencyEntity>
    @Published var searchText = ""

    init() {
        currencies = CurrencyEntity.fetchRequest(sortingBy: [.byCode(.forward)])

        ValidationHelper.search($searchText)
            .map { text in
                text.isEmpty
                    ? CurrencyEntity.fetchRequest(sortingBy: [.byCode(.forward)])
                    : CurrencyEntity.fetchRequest(filteringBy: [.codeContains(text), .nameContains(text)], sortingBy: [.byCode(.forward)])
            }
            .assign(to: &$currencies)
    }
}
