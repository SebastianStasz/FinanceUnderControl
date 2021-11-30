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
    private var cancellables: Set<AnyCancellable> = []

    struct Input {
        let selectCurrency = PassthroughSubject<CurrencyEntity, Never>()
    }

    @Published private(set) var currencies: FetchRequest<CurrencyEntity>
    @Published var selectedCurrency: CurrencyEntity?
    @Published var searchText = ""
    let input = Input()

    init() {
        currencies = CurrencyEntity.fetchRequest(sortingBy: [.byCode(.forward)])

        input.selectCurrency
            .sink { [weak self] currency in
                self?.selectedCurrency = currency
            }
            .store(in: &cancellables)

        $searchText
            .dropFirst()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.currencies = text.isEmpty
                    ? CurrencyEntity.fetchRequest(sortingBy: [.byCode(.forward)])
                    : CurrencyEntity.fetchRequest(filteringBy: [.codeContains(text), .nameContains(text)], sortingBy: [.byCode(.forward)])
            }
            .store(in: &cancellables)
    }
}
