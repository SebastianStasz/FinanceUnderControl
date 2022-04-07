//
//  CurrencyEntity+CoreDataProperties.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//
//

import CoreData
import Domain
import Foundation
import Shared

@objc(CurrencyEntity) public class CurrencyEntity: NSManagedObject, Entity {
    @NSManaged private var nameKey: String
    @NSManaged public private(set) var code: String
    @NSManaged public private(set) var updateDate: Date?
    @NSManaged public private(set) var exchangeRates: Set<ExchangeRateEntity>
    @NSManaged public private(set) var cashFlows: Set<CashFlowEntity>
}

// MARK: - Properties

public extension CurrencyEntity {

    var name: String {
        nameKey.localize()
    }

    var updateDateString: String? {
        updateDate?.string(format: .medium)
    }

    var exchangeRatesArray: [ExchangeRateEntity] {
        exchangeRates.sorted { $0.code < $1.code }
    }
}

// MARK: - Methods

public extension CurrencyEntity {

    @discardableResult static func create(in context: NSManagedObjectContext, model: Model) -> CurrencyEntity? {
        guard currencyNotExist(withCode: model.code, in: context) else { return nil }
        let currency = CurrencyEntity(context: context)
        currency.code = model.code
        currency.nameKey = model.nameKey
        currency.updateDate = nil
        return currency
    }

    static func create(in context: NSManagedObjectContext, models: [Model]) {
        for model in models {
            guard let currency = CurrencyEntity.create(in: context, model: model) else { continue }
            currency.addExchangeRates(SupportedCurrency.allCases.map { ExchangeRateEntity.Model(code: $0.code, rateValue: 0, baseCurrency: currency.code) })
        }
    }

    func addExchangeRates(_ exchangeRatesData: [ExchangeRateEntity.Model]) {
        guard let context = getContext() else { return }
        let exchangeRatesData = exchangeRatesData.filter { $0.code != self.code }
        for exchangeRateData in exchangeRatesData {
            guard exchangeRateNotExist(withCode: exchangeRateData.code) else { continue }
            ExchangeRateEntity.create(in: context, model: exchangeRateData, baseCurrency: self)
        }
    }

    func updateExchangeRates(with exchageRatesData: [ExchangeRateEntity.Model]) {
        guard let context = getContext() else { return }
        context.performAndWait {
            self.updateDate = Date()
            for exchangeRateData in exchageRatesData {
                let exchageRate = self.exchangeRates.first(where: { $0.code == exchangeRateData.code })
                exchageRate?.updateRateValue(to: exchangeRateData.rateValue)
            }
        }
    }

    static func getAll(from context: NSManagedObjectContext) -> [CurrencyEntity] {
        let request = CurrencyEntity.nsFetchRequest(sortingBy: [.byCode(.forward)])
        let result = try? context.fetch(request)
        return result ?? []
    }

    static func get(withCode code: String, from context: NSManagedObjectContext) -> CurrencyEntity? {
        let request = CurrencyEntity.nsFetchRequest(filteringBy: [.codeIs(code)])
        let currency = try? context.fetch(request).first
        return currency
    }

    func getExchangeRate(for currencyCode: String) -> ExchangeRateEntity? {
        exchangeRatesArray.first(where: { $0.code == currencyCode })
    }

    private func exchangeRateNotExist(withCode code: String) -> Bool {
        !exchangeRates.contains(where: { $0.code == code })
    }

    static private func currencyNotExist(withCode code: String, in context: NSManagedObjectContext) -> Bool {
        let request = CurrencyEntity.nsFetchRequest(filteringBy: [.codeContains(code)])
        let result = try? context.fetch(request)
        return result?.count == 0
    }
}

// MARK: - Generated accessors for exchangeRates

private extension CurrencyEntity {

    @objc(addExchangeRatesObject:)
    @NSManaged func addToExchangeRates(_ value: ExchangeRateEntity)

    @objc(removeExchangeRatesObject:)
    @NSManaged func removeFromExchangeRates(_ value: ExchangeRateEntity)

    @objc(addExchangeRates:)
    @NSManaged func addToExchangeRates(_ values: NSSet)

    @objc(removeExchangeRates:)
    @NSManaged func removeFromExchangeRates(_ values: NSSet)

}

// MARK: - Helpers

public extension CurrencyEntity {
    static func sampleEUR(in context: NSManagedObjectContext) -> CurrencyEntity {
        let currency = CurrencyEntity.create(in: context, model: .eur)!
        let eurRatesData = try! JSONDecoder().decode(LatestRatesResponse.self, from: DataFile.exchangerateLatestEur.data) // swiftlint:disable:this force_try
        currency.addExchangeRates(eurRatesData.rates.map { $0.exchangeRateData(baseCurrency: currency.code) })
        return currency
    }
}
