//
//  CurrencyEntityTests.swift
//  FinanceCoreDataTests
//
//  Created by Sebastian Staszczyk on 14/11/2021.
//

import Domain
import XCTest
@testable import FinanceCoreData

final class CurrencyEntityTests: XCTestCase, CoreDataSteps {

    var context = PersistenceController.previewEmpty.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Tests

    func test_create_currency_entity() throws {
        // Define currency data.
        let currencyData = Currency.eur

        // Before creating, there should not be any currencies.
        try fetchRequestShouldReturnElements(0, for: CurrencyEntity.self)

        // Create currency entity using defined data.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: currencyData))

        // Try to create second currency entity using the same data.
        createCurrencyEntity(data: currencyData)

        // After creating, there should be one currency entity.
        try fetchRequestShouldReturnElements(1, for: CurrencyEntity.self)

        // Verify that currency entity data is correct.
        try verifyCurrencyData(in: currencyEntity, data: currencyData, wasUpdated: false)

        // Save context.
        try saveContext()
    }

    func test_add_exchange_rates() throws {
        // Define currency data.
        let currencyData = Currency.pln

        // Create currency entity using defined data.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: currencyData))

        // Define exchange rates data.
        let exchangeRatesData: [ExchangeRateData] = [.eurInPln, .usdInPln]

        // Add exchange rates to currency entity.
        currencyEntity.addExchangeRates(exchangeRatesData)

        // Verify currency data is correct.
        try verifyCurrencyData(in: currencyEntity, data: currencyData, wasUpdated: true, exchangeRates: exchangeRatesData)
    }

    func test_update_exchange_rates() throws {
        // Define currency data.
        let currencyData = Currency.pln

        // Create currency entity using defined data.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: currencyData))

        // Define exchange rates data.
        let exchangeRatesData: [ExchangeRateData] = [.eurInPln, .usdInPln]

        // Add exchange rates to currency entity.
        currencyEntity.addExchangeRates(exchangeRatesData)

        // Define exchange rates data.
        let exchangeRatesData2: [ExchangeRateData] = [.eurInPln2, .usdInPln2]

        // Update exchange rates.
        currencyEntity.updateExchangeRates(with: exchangeRatesData2)

        // Verify currency data is correct.
        try verifyCurrencyData(in: currencyEntity, data: currencyData, wasUpdated: true, exchangeRates: exchangeRatesData2)
    }

    func test_delete_currency_entity() throws {
        // Create currency entity using sample data.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: .pln))

        // Define exchange rates data.
        let exchangeRatesData: [ExchangeRateData] = [.eurInPln, .usdInPln]

        // Add exchange rates to currency entity.
        currencyEntity.addExchangeRates(exchangeRatesData)

        // Delete currency entity.
        currencyEntity.delete()

        // Verify that currency entity was deleted.
        try fetchRequestShouldReturnElements(0, for: CurrencyEntity.self)

        // Verify that exchange rates related to this entity were deleted.
        try fetchRequestShouldReturnElements(0, for: ExchangeRateEntity.self)

        // Save context.
        try saveContext()
    }
}

// MARK: - Steps

private extension CurrencyEntityTests {

    func verifyCurrencyData(in entity: CurrencyEntity, data: Currency, wasUpdated: Bool, exchangeRates: [ExchangeRateData] = []) throws {
        XCTAssertEqual(entity.name, data.name)
        XCTAssertEqual(entity.code, data.code)
        wasUpdated ? XCTAssertNotNil(entity.updateDate) : XCTAssertNil(entity.updateDate)
        XCTAssertEqual(entity.exchangeRates.count, exchangeRates.count)
        for exchangeRate in entity.exchangeRates {
            XCTAssert(exchangeRates.contains(where: {
                $0.code == exchangeRate.code && $0.rateValue == exchangeRate.rateValue
            }))
        }
    }
}
