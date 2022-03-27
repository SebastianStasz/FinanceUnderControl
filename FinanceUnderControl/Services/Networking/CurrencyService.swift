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
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        setupCurrencies()
    }

    private func setupCurrencies() {
        let currencies = CurrencyEntity.getAll(from: context)

        let nonExistingCurrencies = SupportedCurrency.currencyEntityModels
            .filter { currency in currencies.notContains(where: { $0.code == currency.code }) }

        CurrencyEntity.create(in: context, models: nonExistingCurrencies)
    }
}
