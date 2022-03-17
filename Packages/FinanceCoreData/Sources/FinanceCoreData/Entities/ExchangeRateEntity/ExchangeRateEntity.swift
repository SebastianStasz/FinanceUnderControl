//
//  ExchangeRateEntity+CoreDataProperties.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 26/10/2021.
//
//

import CoreData
import Foundation
import SSUtils

@objc(ExchangeRateEntity) public class ExchangeRateEntity: NSManagedObject, Entity {
    @NSManaged public private(set) var code: String
    @NSManaged public private(set) var rateValue: Double
    @NSManaged public private(set) var baseCurrency: CurrencyEntity

    public var rateValueRounded: String {
        rateValue.asString(roundToDecimalPlaces: 2)
    }
}

// MARK: - Methods

public extension ExchangeRateEntity {

    @discardableResult static func create(in context: NSManagedObjectContext,
                                          exchangeRateData data: ExchangeRateData,
                                          baseCurrency: CurrencyEntity
    ) -> ExchangeRateEntity {
        let exchangeRate = ExchangeRateEntity(context: context)
        exchangeRate.code = data.code
        exchangeRate.rateValue = data.rateValue
        exchangeRate.baseCurrency = baseCurrency
        return exchangeRate
    }

    func updateRateValue(to value: Double) {
        self.rateValue = value
    }
}

// MARK: - Helpers

extension ExchangeRateEntity: Removable {}
