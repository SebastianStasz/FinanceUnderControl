//
//  PersistenceControllerPreview.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Domain
import Foundation
import CoreData

public extension PersistenceController {

    static var previewEmpty: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        persistenceController.save()
        return persistenceController
    }

    static var preview: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        let context = persistenceController.context

        createCurrencies(in: context)
        createCashFlowCategories(in: context)

//        persistenceController.save()
        return persistenceController
    }

    static private func createCurrencies(in context: NSManagedObjectContext) {
        let decoder = JSONDecoder()
        let symbolsReponse = try! decoder.decode(SymbolsReponse.self, from: DataFile.exchangerateSymbols.data)
        let latestRatesResponse = try! decoder.decode(LatestRatesResponse.self, from: DataFile.exchangerateLatestEur.data)

        CurrencyEntity.create(in: context, currenciesData: symbolsReponse.currencies)
        let eurCurrency = CurrencyEntity.getAll(from: context).first(where: { $0.code == "EUR" })!
        eurCurrency.addExchangeRates(latestRatesResponse.rates.map { $0.exchangeRateData(baseCurrency: "EUR") })
    }

    static private func createCashFlowCategories(in context: NSManagedObjectContext) {
        CashFlowCategoryData.sampleIncomes.forEach {
            CashFlowCategoryEntity.create(in: context, data: $0)
        }

        CashFlowCategoryData.sampleExpenses.forEach {
            CashFlowCategoryEntity.create(in: context, data: $0)
        }
    }
}
