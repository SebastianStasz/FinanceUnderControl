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

@objc(CurrencyEntity) public class CurrencyEntity: NSManagedObject, Entity {
    @NSManaged private var name_: String
    @NSManaged private var updateDate_: Date?
    @NSManaged public private(set) var code: String
    @NSManaged public private(set) var exchangeRates: Set<ExchangeRateEntity>
}

// MARK: - Properties

public extension CurrencyEntity {

    var name: String {
        name_
    }

    var updateDate: String? {
        updateDate_?.string(format: .medium)
    }
}

// MARK: - Methods

public extension CurrencyEntity {

    @discardableResult static func create(in context: NSManagedObjectContext, currencyData data: Currency) -> CurrencyEntity? {
        guard currencyNotExist(withCode: data.code, in: context) else { return nil }
        let currency = CurrencyEntity(context: context)
        currency.code = data.code
        currency.name_ = data.name
        currency.updateDate_ = nil
        return currency
    }

    func addExchangeRates(_ exchangeRatesData: [ExchangeRateData]) {
        guard let context = self.getContext() else { return }
        updateDate_ = Date()
        for exchangeRateData in exchangeRatesData {
            guard exchangeRateNotExist(withCode: exchangeRateData.code) else { continue }
            ExchangeRateEntity.create(in: context, exchangeRateData: exchangeRateData, baseCurrency: self)
        }
    }

    func updateExchangeRates(with exchageRatesData: [ExchangeRateData]) {
        self.updateDate_ = Date()
        for exchangeRateData in exchageRatesData {
            let exchageRate = self.exchangeRates.first(where: { $0.code == exchangeRateData.code })
            exchageRate?.updateRateValue(to: exchangeRateData.rateValue)
        }
    }

    private func exchangeRateNotExist(withCode code: String) -> Bool {
        !exchangeRates.contains(where: { $0.code == code })
    }

    static private func currencyNotExist(withCode code: String, in context: NSManagedObjectContext) -> Bool {
        let request = CurrencyEntity.getAllNSFetchRequest(filteringBy: [.byCode(code)])
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

extension CurrencyEntity: Identifiable {}
