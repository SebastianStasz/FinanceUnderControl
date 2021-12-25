//
//  PersistenceControllerPreview.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Domain
import Foundation

public extension PersistenceController {

    static var previewEmpty: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        persistenceController.save()
        return persistenceController
    }

    static var preview: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        let context = persistenceController.context

        let decoder = JSONDecoder()
        let symbolsReponse = try! decoder.decode(SymbolsReponse.self, from: DataFile.exchangerateSymbols.data)
        let latestRatesResponse = try! decoder.decode(LatestRatesResponse.self, from: DataFile.exchangerateLatestEur.data)

        CurrencyEntity.create(in: context, currenciesData: symbolsReponse.currencies)
        let eurCurrency = CurrencyEntity.getAll(from: context).first(where: { $0.code == "EUR" })!
        eurCurrency.addExchangeRates(latestRatesResponse.rates.map { $0.exchangeRateData(baseCurrency: "EUR") })
//        persistenceController.save()
        return persistenceController
    }
}
