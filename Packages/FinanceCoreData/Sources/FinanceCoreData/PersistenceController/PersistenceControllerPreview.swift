//
//  PersistenceControllerPreview.swift
//  FinanceCoreData
//
//  Created by sebastianstaszczyk on 19/04/2022.
//

import CoreData
import Foundation
import Shared

public extension PersistenceController {

    static var previewEmpty: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        persistenceController.save()
        return persistenceController
    }

    static var preview: PersistenceController {
        let persistenceController = PersistenceController(inMemory: true)
        createSampleData(in: persistenceController.context)
        persistenceController.save()
        return persistenceController
    }
}

private extension PersistenceController {

    static func createSampleData(in context: NSManagedObjectContext) {
        createCurrencies(in: context)

        let pln = CurrencyEntity.get(withCode: "PLN", from: context)!

        // MARK: Expenses

        let rentCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Czynsz", icon: .houseFill, type: .expense))
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Dom", type: .expense, color: .mint, categories: [rentCat]))

        let groceriesCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Artykuły spożywcze", icon: .cartFill, type: .expense))
        let restaurantsAndDeliveryCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Restauracje i dowóz", icon: .takeoutbagAndCupAndStrawFill, type: .expense))
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Jedzenie", type: .expense, color: .yellow, categories: [groceriesCat, restaurantsAndDeliveryCat]))

        let clothes = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Ubrania i akcesoria", icon: .tshirtFill, type: .expense))
        let shoes = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Buty", icon: .figureWalk, type: .expense))
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Outfit", type: .expense, color: .cyan, categories: [clothes, shoes]))

        let petrolCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Paliwo", icon: .fuelpumpFill, type: .expense))
        let carRepairAndParts = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Naprawa i modyfikacja", icon: .carFill, type: .expense))
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Samochód", type: .expense, color: .indigo, categories: [petrolCat, carRepairAndParts]))

        let spotify = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Spotify", icon: .headphones, type: .expense))
        let netflix = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Netflix", icon: .ticketFill, type: .expense))
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Subskrypcje", type: .expense, color: .pink, categories: [spotify, netflix]))

        let charityCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Dobroczynność", icon: .heartFill, type: .expense))
        let petCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Florek", icon: .pawprintFill, type: .expense))

        CashFlowEntity.create(in: context, model: .init(name: "Czynsz 1", date: date(day: 11, monthOffset: -3), value: .rentalValue, currency: pln, category: rentCat))
        CashFlowEntity.create(in: context, model: .init(name: "Czynsz 2", date: date(day: 5, monthOffset: -2), value: .rentalValue, currency: pln, category: rentCat))
        CashFlowEntity.create(in: context, model: .init(name: "Czynsz 3", date: date(day: 9, monthOffset: -1), value: .rentalValue, currency: pln, category: rentCat))
        CashFlowEntity.create(in: context, model: .init(name: "Czynsz 4", date: date(day: 11, monthOffset: 0), value: .rentalValue, currency: pln, category: rentCat))

        CashFlowEntity.create(in: context, model: .init(name: "Bahra kebab", date: date(day: 8, monthOffset: -3), value: 21, currency: pln, category: restaurantsAndDeliveryCat))
        CashFlowEntity.create(in: context, model: .init(name: "NYP Department", date: date(day: 15, monthOffset: -2), value: 23, currency: pln, category: restaurantsAndDeliveryCat))
        CashFlowEntity.create(in: context, model: .init(name: "Good Lood", date: date(day: 17, monthOffset: -1), value: 8, currency: pln, category: restaurantsAndDeliveryCat))
        CashFlowEntity.create(in: context, model: .init(name: "Pizzeria Flamenco", date: date(day: 27, monthOffset: 0), value: 55, currency: pln, category: restaurantsAndDeliveryCat))

        let shopNames = ["Biedronka", "Lidl", "Żabka", "Lewiatan", "Auchan"]
        (1...9).forEach { _ in
            let day = (0...30).randomElement()!
            CashFlowEntity.create(in: context, model: .init(name: shopNames.randomElement()!, date: date(day: day, monthOffset: -3), value: .groceriesValue, currency: pln, category: groceriesCat))
        }
        (1...12).forEach { _ in
            let day = (0...30).randomElement()!
            CashFlowEntity.create(in: context, model: .init(name: shopNames.randomElement()!, date: date(day: day, monthOffset: -2), value: .groceriesValue, currency: pln, category: groceriesCat))
        }
        (1...11).forEach { _ in
            let day = (0...30).randomElement()!
            CashFlowEntity.create(in: context, model: .init(name: shopNames.randomElement()!, date: date(day: day, monthOffset: -1), value: .groceriesValue, currency: pln, category: groceriesCat))
        }
        (1...15).forEach { _ in
            let day = (0...30).randomElement()!
            CashFlowEntity.create(in: context, model: .init(name: shopNames.randomElement()!, date: date(day: day, monthOffset: 0), value: .groceriesValue, currency: pln, category: groceriesCat))
        }

        CashFlowEntity.create(in: context, model: .init(name: "Nike", date: date(day: 11, monthOffset: -2), value: .clothesValue, currency: pln, category: clothes))
        CashFlowEntity.create(in: context, model: .init(name: "Zalando", date: date(day: 5, monthOffset: -2), value: .clothesValue, currency: pln, category: clothes))
        CashFlowEntity.create(in: context, model: .init(name: "Eobuwie", date: date(day: 9, monthOffset: -1), value: .clothesValue, currency: pln, category: clothes))
        CashFlowEntity.create(in: context, model: .init(name: "Adidas", date: date(day: 11, monthOffset: -1), value: .clothesValue, currency: pln, category: clothes))

        CashFlowEntity.create(in: context, model: .init(name: "Eobuwie", date: date(day: 9, monthOffset: -1), value: .clothesValue, currency: pln, category: shoes))
        CashFlowEntity.create(in: context, model: .init(name: "Buty Puma", date: date(day: 11, monthOffset: -0), value: .clothesValue, currency: pln, category: shoes))

        CashFlowEntity.create(in: context, model: .init(name: "Orlen", date: date(day: 1, monthOffset: -3), value: .petrolValue, currency: pln, category: petrolCat))
        CashFlowEntity.create(in: context, model: .init(name: "Orlen", date: date(day: 6, monthOffset: -2), value: .petrolValue, currency: pln, category: petrolCat))
        CashFlowEntity.create(in: context, model: .init(name: "BP", date: date(day: 14, monthOffset: -2), value: .petrolValue, currency: pln, category: petrolCat))
        CashFlowEntity.create(in: context, model: .init(name: "Orlen", date: date(day: 3, monthOffset: -1), value: .petrolValue, currency: pln, category: petrolCat))
        CashFlowEntity.create(in: context, model: .init(name: "BP", date: date(day: 20, monthOffset: -1), value: .petrolValue, currency: pln, category: petrolCat))
        CashFlowEntity.create(in: context, model: .init(name: "Orlen", date: date(day: 6, monthOffset: 0), value: .petrolValue, currency: pln, category: petrolCat))
        CashFlowEntity.create(in: context, model: .init(name: "BP", date: date(day: 30, monthOffset: 0), value: .petrolValue, currency: pln, category: petrolCat))

        CashFlowEntity.create(in: context, model: .init(name: "Nowe opony", date: date(day: 23, monthOffset: -1), value: 4200, currency: pln, category: carRepairAndParts))
        CashFlowEntity.create(in: context, model: .init(name: "Wymiana klocków hamulcowych", date: date(day: 17, monthOffset: 0), value: 570.23, currency: pln, category: carRepairAndParts))

        CashFlowEntity.create(in: context, model: .init(name: "Spotify 1", date: date(day: 16, monthOffset: -3), value: 10, currency: pln, category: spotify))
        CashFlowEntity.create(in: context, model: .init(name: "Spotify 2", date: date(day: 16, monthOffset: -2), value: 10, currency: pln, category: spotify))
        CashFlowEntity.create(in: context, model: .init(name: "Spotify 3", date: date(day: 16, monthOffset: -1), value: 10, currency: pln, category: spotify))
        CashFlowEntity.create(in: context, model: .init(name: "Spotify 4", date: date(day: 16, monthOffset: 0), value: 10, currency: pln, category: spotify))

        CashFlowEntity.create(in: context, model: .init(name: "Netflix 1", date: date(day: 21, monthOffset: -3), value: 60, currency: pln, category: netflix))
        CashFlowEntity.create(in: context, model: .init(name: "Netflix 2", date: date(day: 21, monthOffset: -2), value: 60, currency: pln, category: netflix))
        CashFlowEntity.create(in: context, model: .init(name: "Netflix 3", date: date(day: 21, monthOffset: -1), value: 60, currency: pln, category: netflix))
        CashFlowEntity.create(in: context, model: .init(name: "Netflix 4", date: date(day: 21, monthOffset: 0), value: 60, currency: pln, category: netflix))

        CashFlowEntity.create(in: context, model: .init(name: "SIEPOMAGA", date: date(day: 10, monthOffset: -3), value: .charityValue, currency: pln, category: charityCat))
        CashFlowEntity.create(in: context, model: .init(name: "SIEPOMAGA", date: date(day: 18, monthOffset: -2), value: .charityValue, currency: pln, category: charityCat))
        CashFlowEntity.create(in: context, model: .init(name: "SIEPOMAGA", date: date(day: 26, monthOffset: -1), value: .charityValue, currency: pln, category: charityCat))
        CashFlowEntity.create(in: context, model: .init(name: "SIEPOMAGA", date: date(day: 25, monthOffset: 0), value: .charityValue, currency: pln, category: charityCat))

        CashFlowEntity.create(in: context, model: .init(name: "Jedzenie dla psa", date: date(day: 2, monthOffset: -3), value: .petValue, currency: pln, category: petCat))
        CashFlowEntity.create(in: context, model: .init(name: "Jedzenie dla psa", date: date(day: 19, monthOffset: -3), value: .petValue, currency: pln, category: petCat))
        CashFlowEntity.create(in: context, model: .init(name: "Jedzenie dla psa", date: date(day: 29, monthOffset: -2), value: .petValue, currency: pln, category: petCat))
        CashFlowEntity.create(in: context, model: .init(name: "Jedzenie dla psa", date: date(day: 5, monthOffset: -1), value: .petValue, currency: pln, category: petCat))
        CashFlowEntity.create(in: context, model: .init(name: "Jedzenie dla psa", date: date(day: 17, monthOffset: -1), value: .petValue, currency: pln, category: petCat))
        CashFlowEntity.create(in: context, model: .init(name: "Jedzenie dla psa", date: date(day: 25, monthOffset: 0), value: .petValue, currency: pln, category: petCat))
        CashFlowEntity.create(in: context, model: .init(name: "Jedzenie dla psa", date: date(day: 13, monthOffset: 0), value: .petValue, currency: pln, category: petCat))

        // MARK: Incomes

        let cryptoCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Kryptowaluty", icon: .circleGrid2x2Fill, type: .income))
        let stockCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Giełda", icon: .chartBarXaxis, type: .income))
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Inwestycje", type: .income, color: .blue, categories: [cryptoCat, stockCat]))

        let paymentCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Wypłata", icon: .suitcaseFill, type: .income))
        let bonusCat = CashFlowCategoryEntity.createAndReturn(in: context, model: .init(name: "Premia", icon: .flameFill, type: .income))
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Praca", type: .income, color: .green, categories: [paymentCat, bonusCat]))

        CashFlowEntity.create(in: context, model: .init(name: "BTC", date: date(day: 12, monthOffset: -2), value: 15000, currency: pln, category: cryptoCat))
        CashFlowEntity.create(in: context, model: .init(name: "Tesla", date: date(day: 11, monthOffset: -1), value: 2600.48, currency: pln, category: stockCat))

        CashFlowEntity.create(in: context, model: .init(name: "Wypłata 1", date: date(day: 12, monthOffset: -3), value: .paymentValue, currency: pln, category: paymentCat))
        CashFlowEntity.create(in: context, model: .init(name: "Wypłata 2", date: date(day: 13, monthOffset: -2), value: .paymentValue, currency: pln, category: paymentCat))
        CashFlowEntity.create(in: context, model: .init(name: "Wypłata 3", date: date(day: 12, monthOffset: -1), value: .paymentValue, currency: pln, category: paymentCat))
        CashFlowEntity.create(in: context, model: .init(name: "Wypłata 4", date: date(day: 11, monthOffset: 0), value: .paymentValue, currency: pln, category: paymentCat))
    }

    static func date(day: Int, monthOffset: Int) -> Date {
        let now = Date.now
        let year = Calendar.current.component(.year, from: now)
        let month = Calendar.current.component(.month, from: now)
        let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
        return Calendar.current.date(byAdding: .month, value: monthOffset, to: date)!
    }

    static func createCurrencies(in context: NSManagedObjectContext) {
        CurrencyEntity.create(in: context, models: Currency.currencyEntityModels)
    }
}

// MARK: -- Random values for cash flows

private extension Decimal {
    static var paymentValue: Decimal {
        randomBetween(5000, and: 7000)
    }

    static var rentalValue: Decimal {
        randomBetween(1100, and: 1450)
    }

    static var petValue: Decimal {
        randomBetween(50, and: 190)
    }

    static var charityValue: Decimal {
        randomBetween(20, and: 300)
    }

    static var petrolValue: Decimal {
        randomBetween(90, and: 320)
    }

    static var clothesValue: Decimal {
        randomBetween(50, and: 370)
    }

    static var groceriesValue: Decimal {
        randomBetween(20, and: 50)
    }
}
