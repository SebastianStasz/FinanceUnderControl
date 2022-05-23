//
//  CurrencyService.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 23/11/2021.
//

import CoreData
import FinanceCoreData
import Foundation
import Shared

final class CurrencyService {

    private let exchangeRateService = ExchangeRateService()

    func setupCurrencies(in context: NSManagedObjectContext) async {
        let currencies = getCurrencies(from: context)

        for currency in currencies {
            guard let date = currency.updateDate,
                    Calendar.current.dateComponents([.day], from: date, to: .now).day! < 1
            else {
                await updateExchangeRates(for: currency)
                continue
            }
        }
        try! AppVM.shared.context.save()
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

        let nonExistingSupportedCurrencies = Currency.currencyEntityModels
            .filter { currency in currencies.notContains(where: { $0.code == currency.code }) }

        guard nonExistingSupportedCurrencies.isEmpty else {
            CurrencyEntity.create(in: context, models: nonExistingSupportedCurrencies)
            return CurrencyEntity.getAll(from: context)
        }
        return currencies
    }
}
