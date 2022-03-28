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
import Shared

final class ExchangeRateService {

    private let apiService: APIService

    init(apiService: APIService = .shared) {
        self.apiService = apiService
    }

    func getLatestExchangeRates(for currency: String) async throws -> LatestRatesResponse {
        try await apiService.execute(GetLatestExchangeRatesRequest(for: currency), type: .exchangerate)
    }

//    func getLatestExchangeRates(for currency: String) -> AnyPublisher<LatestRatesResponse, Error> {
//        apiService.execute(GetLatestExchangeRates(for: currency), type: .exchangerate)
//    }
}

final class CurrencyService {

    private let exchangeRateService = ExchangeRateService()

    func setupCurrencies(in context: NSManagedObjectContext) async {
        let currencies = getCurrencies(from: context)

        for currency in currencies {
            guard let date = currency.updateDate,
                    Calendar.current.dateComponents([.day], from: date, to: .now).day! > 1
            else {
                await updateExchangeRates(for: currency)
                continue
            }
        }
    }

    private func updateExchangeRates(for currency: CurrencyEntity) async {
        do {
            let response = try await exchangeRateService.getLatestExchangeRates(for: currency.code)
            let exchangeRates = response.rates.map { ExchangeRateEntity.Model(code: $0.code, rateValue: $0.rate, baseCurrency: response.base) }
            currency.updateExchangeRates(with: exchangeRates)
        } catch let error {
            print("CurrencyService - update exchange rates error: \(error)")
        }
    }

    private func getCurrencies(from context: NSManagedObjectContext) -> [CurrencyEntity] {
        let currencies = CurrencyEntity.getAll(from: context)

        let nonExistingSupportedCurrencies = SupportedCurrency.currencyEntityModels
            .filter { currency in currencies.notContains(where: { $0.code == currency.code }) }

        guard nonExistingSupportedCurrencies.isEmpty else {
            CurrencyEntity.create(in: context, models: nonExistingSupportedCurrencies)
            return CurrencyEntity.getAll(from: context)
        }
        return currencies
    }
}
