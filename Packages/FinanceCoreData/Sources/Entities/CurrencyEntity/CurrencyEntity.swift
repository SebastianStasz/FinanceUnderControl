//
//  CurrencyEntity+CoreDataProperties.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//
//

import CoreData
import Foundation

@objc(CurrencyEntity) public class CurrencyEntity: NSManagedObject, Entity {
    @NSManaged private var name_: String
    @NSManaged private var updateDate_: Date?
    @NSManaged public private(set) var code: String
    @NSManaged public private(set) var exchangeRates: Set<ExchangeRateEntity>
}

// MARK: - Properties

public extension CurrencyEntity {

    public var name: String {
        name_.localize()
    }

    public var updateDate: String? {
        updateDate_?.description // TODO: Use date formatter
    }
}

// MARK: - Methods

private extension CurrencyEntity {

    @discardableResult static func create(in context: NSManagedObjectContext, currencyData data: CurrencyData) -> CurrencyEntity {
        let currency = CurrencyEntity(context: context)
        currency.code = data.code
        currency.name_ = data.name
        currency.updateDate = nil
        return currency
    }
}

// MARK: - Generated accessors for exchangeRates

extension CurrencyEntity {

    @objc(addExchangeRatesObject:)
    @NSManaged public func addToExchangeRates(_ value: ExchangeRateEntity)

    @objc(removeExchangeRatesObject:)
    @NSManaged public func removeFromExchangeRates(_ value: ExchangeRateEntity)

    @objc(addExchangeRates:)
    @NSManaged public func addToExchangeRates(_ values: NSSet)

    @objc(removeExchangeRates:)
    @NSManaged public func removeFromExchangeRates(_ values: NSSet)

}

// MARK: - Helpers

extension CurrencyEntity: Identifiable {}
