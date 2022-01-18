//
//  CurrencyService.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 23/11/2021.
//

import Combine
import CoreData
import Domain
import FinanceCoreData
import Foundation

final class CurrencyService {
    private var cancellables: Set<AnyCancellable> = []
    private lazy var exchangerateService = ExchangerateService()
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context

        getNotExistingCurrencies()
            .sink { completion in
                if case .failure = completion {
                    print("CurrencyService: Error")
                }
            } receiveValue: { newCurrencies in
                CurrencyEntity.create(in: context, currenciesData: newCurrencies)
            }
            .store(in: &cancellables)
    }

    private func getNotExistingCurrencies() -> AnyPublisher<[Currency], Error> {
        let currencies = CurrencyEntity.getAll(from: context)
        return exchangerateService.getSupportedCurrencies()
            .map { symbolsResponse in
                symbolsResponse.currencies.filter { currency in
                    !currencies.contains(where: { $0.code == currency.code })
                }
            }
            .eraseToAnyPublisher()
    }
}
