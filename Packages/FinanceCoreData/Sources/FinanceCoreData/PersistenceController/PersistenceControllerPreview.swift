//
//  PersistenceControllerPreview.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//

import Domain
import Foundation
import CoreData
import Shared

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
        persistenceController.save()
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
        CurrencyEntity.create(in: context, models: Currency.currencyEntityModels)
    }

    // MARK: - Expenses

    static func createExpenses(in context: NSManagedObjectContext) {
        createCashFlows(in: context,
                        names: ["Biedronka", "Biedronka", "Biedronka", "Żabka", "Pizza", "Żabka"],
                        values: [45.2, 12.2, 78.9, 41.5, 102.51, 37.39],
                        categoryName: "Food",
                        categoryIcon: .pillsFill,
                        categoryType: .expense,
                        groupName: "Food and drink",
                        groupColor: .red)

        createCashFlows(in: context,
                        names: ["Engine oil", "Brakes replacement", "Car inspection"],
                        values: [60, 1240, 230],
                        categoryName: "Car maintenance",
                        categoryIcon: .carFill,
                        categoryType: .expense,
                        groupName: "Car",
                        groupColor: .gray)

        createCashFlows(in: context,
                        names: ["Bike parts", "Guitar Yamaha F310", "Bicycle helmet", "Tatoo"],
                        values: [31, 610, 257, 1400],
                        categoryName: "Hobby",
                        categoryIcon: .leafFill,
                        categoryType: .expense,
                        groupColor: .pink)

        createCashFlows(in: context,
                        names: ["Orlen", "Orlen", "Orlen"],
                        values: [120, 303, 65],
                        categoryName: "Fuel",
                        categoryIcon: .fuelpumpFill,
                        categoryType: .expense,
                        groupName: "Car",
                        groupColor: .yellow)

        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Housing", type: .expense, color: .cyan))
    }

    // MARK: - Incomes

    static func createIncomes(in context: NSManagedObjectContext) {
        createCashFlows(in: context,
                        names: ["Month 1", "Month 2", "Month 3"],
                        values: [4200, 4500, 5100],
                        categoryName: "Payment",
                        categoryIcon: .bagFill,
                        categoryType: .income,
                        groupName: "Work",
                        groupColor: .green)

        createCashFlows(in: context,
                        names: ["Bonus"],
                        values: [210],
                        categoryName: "Bonus",
                        categoryIcon: .bagFill,
                        categoryType: .income,
                        groupName: "Work",
                        groupColor: .green)

        createCashFlows(in: context,
                        names: ["BTC", "ETH"],
                        values: [600, 3230],
                        categoryName: "Crypto",
                        categoryIcon: .banknoteFill,
                        categoryType: .income,
                        groupName: "Investments",
                        groupColor: .red)
    }

    // MARK: - Helpers

    static func createCashFlows(in context: NSManagedObjectContext,
                                names: [String],
                                values: [Decimal],
                                categoryName: String,
                                categoryIcon: CashFlowCategoryIcon,
                                categoryType: CashFlowType,
                                groupName: String? = nil,
                                groupColor: CashFlowCategoryColor
    ) {
        guard names.count == values.count else {
            fatalError("Each name should be associated with one value.")
        }
        let category = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: categoryName, icon: categoryIcon, type: categoryType))
        for (name, value) in zip(names, values) {
            CashFlowEntity.createAndReturn(in: context, model: .init(name: name, date: date, value: value, currency: plnCurrency(in: context), category: category))
        }
        if let groupName = groupName {
            let request = CashFlowCategoryGroupEntity.nsFetchRequest(filteringBy: [.name(groupName)])
            let result = try! context.fetch(request) // swiftlint:disable:this force_try
            if result.isEmpty {
                let group = CashFlowCategoryGroupEntity.createAndReturn(in: context, model: .init(name: groupName, type: categoryType, color: groupColor))
                _ = group.addToCategories(category)
            } else {
                _ = result.first?.addToCategories(category)
            }
        }
    }

    static var date: Date {
        Calendar.current.date(byAdding: .day, value: (-58...58).randomElement()!, to: Date())!
    }

    static func plnCurrency(in context: NSManagedObjectContext) -> CurrencyEntity {
        CurrencyEntity.get(withCode: "PLN", from: context)!
    }
}
