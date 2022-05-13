//
//  ExchangeRateEntity+CoreDataProperties.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//
//

import CoreData
import Foundation
import Shared

@objc(ExchangeRateEntity) public class ExchangeRateEntity: NSManagedObject, Entity {
    @NSManaged private var rateValue_: NSDecimalNumber
    @NSManaged public private(set) var code: String
    @NSManaged public private(set) var baseCurrency: CurrencyEntity

    public private(set) var rateValue: Decimal {
        get { rateValue_ as Decimal }
        set { rateValue_ = newValue as NSDecimalNumber }
    }

    public var currency: Currency {
        Currency(rawValue: code)!
    }
}

// MARK: - Methods

public extension ExchangeRateEntity {

    @discardableResult static func create(in context: NSManagedObjectContext,
                                          model: ExchangeRateEntity.Model,
                                          baseCurrency: CurrencyEntity
    ) -> ExchangeRateEntity {
        let exchangeRate = ExchangeRateEntity(context: context)
        exchangeRate.code = model.code
        exchangeRate.rateValue = model.rateValue
        exchangeRate.baseCurrency = baseCurrency
        return exchangeRate
    }

    func updateRateValue(to value: Decimal) {
        self.rateValue = value
    }
}
