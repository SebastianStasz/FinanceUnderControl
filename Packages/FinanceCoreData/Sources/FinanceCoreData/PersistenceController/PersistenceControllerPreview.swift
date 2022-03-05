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
        createSampleData(in: context)
//        persistenceController.save()
        return persistenceController
    }

    static private func createSampleData(in context: NSManagedObjectContext) {
        createCurrencies(in: context)
        createExpenses(in: context)
        createIncomes(in: context)
    }
}

private extension PersistenceController {

    static func createCurrencies(in context: NSManagedObjectContext) {
        let decoder = JSONDecoder()
        let symbolsReponse = try! decoder.decode(SymbolsReponse.self, from: DataFile.exchangerateSymbols.data)
        let latestRatesResponse = try! decoder.decode(LatestRatesResponse.self, from: DataFile.exchangerateLatestEur.data)

        CurrencyEntity.create(in: context, currenciesData: symbolsReponse.currencies)
        let eurCurrency = CurrencyEntity.getAll(from: context).first(where: { $0.code == "EUR" })!
        eurCurrency.addExchangeRates(latestRatesResponse.rates.map { $0.exchangeRateData(baseCurrency: "EUR") })
    }

    // MARK: - Expenses

    static func createExpenses(in context: NSManagedObjectContext) {
        createCashFlows(in: context,
                        names: ["Biedronka", "Biedronka", "Biedronka", "Żabka", "Pizza", "Żabka"],
                        values: [45.2, 12.2, 78.9, 41.5, 102.51, 37.39],
                        categoryName: "Food",
                        categoryIcon: .pillsFill,
                        categoryType: .expense)

        createCashFlows(in: context,
                        names: ["Engine oil", "Brakes replacement", "Car inspection"],
                        values: [60, 1240, 230],
                        categoryName: "Car",
                        categoryIcon: .carFill,
                        categoryType: .expense)

        createCashFlows(in: context,
                        names: ["Bike parts", "Guitar Yamaha F310", "Bicycle helmet", "Tatoo"],
                        values: [31, 610, 257, 1400],
                        categoryName: "Hobby",
                        categoryIcon: .leafFill,
                        categoryType: .expense)

        createCashFlows(in: context,
                        names: ["Orlen", "Orlen", "Orlen"],
                        values: [120, 303, 65],
                        categoryName: "Petrol",
                        categoryIcon: .fuelpumpFill,
                        categoryType: .expense)
    }

    // MARK: - Incomes

    static func createIncomes(in context: NSManagedObjectContext) {
        createCashFlows(in: context,
                        names: ["Payment", "Payment", "Payment", "Work bonus"],
                        values: [4200, 4500, 5100, 210],
                        categoryName: "Work",
                        categoryIcon: .bagFill,
                        categoryType: .income)

        createCashFlows(in: context,
                        names: ["Crypto", "Crypto"],
                        values: [600, 3230],
                        categoryName: "Investments",
                        categoryIcon: .banknoteFill,
                        categoryType: .income)
    }

    // MARK: - Helpers

    static func createCashFlows(in context: NSManagedObjectContext,
                                names: [String],
                                values: [Double],
                                categoryName: String,
                                categoryIcon: CashFlowCategoryIcon,
                                categoryType: CashFlowCategoryType
    ) {
        guard names.count == values.count else {
            fatalError("Each name should be associated with one value.")
        }
        let category = CashFlowCategoryEntity.create(in: context, data: .init(name: categoryName, icon: categoryIcon, type: categoryType))
        for (name, value) in zip(names, values) {
            CashFlowEntity.create(in: context, data: .init(name: name, date: date, value: value, currency: plnCurrency(in: context), category: category))
        }
    }

    static var date: Date {
        Calendar.current.date(byAdding: .day, value: (-58...58).randomElement()!, to: Date())!
    }

    static func plnCurrency(in context: NSManagedObjectContext) -> CurrencyEntity {
        CurrencyEntity.get(withCode: "PLN", from: context)!
    }
}
