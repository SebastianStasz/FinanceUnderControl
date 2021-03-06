//
//  ExchangeRateTests.swift
//  FinanceCoreDataTests
//
//  Created by Sebastian Staszczyk on 14/11/2021.
//

import Domain
import XCTest
@testable import FinanceCoreData

final class ExchangeRateTests: XCTestCase, CoreDataSteps {

    var context = PersistenceController.previewEmpty.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Tests

    func test_create_exchange_rate_entity() throws {
        // Create currency entity that will be used as base currency.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: .pln))

        // Define exhange rate data.
        let exchangeRateData = ExchangeRateEntity.Model.eurInPln

        // Before creating, there should not be any exchange rates.
        try fetchRequestShouldReturnElements(0, for: ExchangeRateEntity.self)

        // Create exchange rate entity using defined data.
        let exchangeRateEntity = createExchangeRateEntity(model: exchangeRateData, baseCurrency: currencyEntity)

        // After creating, there should be one currency entity.
        try fetchRequestShouldReturnElements(1, for: ExchangeRateEntity.self)

        // Verify that currency entity data is correct.
        try verifyExchangeRateData(in: exchangeRateEntity, data: exchangeRateData, baseCurrency: currencyEntity)

        // Save context.
        try saveContext()
    }

    func test_update_rate_value() throws {
        // Create currency entity that will be used as base currency.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: .pln))

        // Define exhange rate data.
        let exchangeRateData = ExchangeRateEntity.Model.eurInPln

        // Create exchange rate entity using defined data.
        let exchangeRateEntity = createExchangeRateEntity(model: exchangeRateData, baseCurrency: currencyEntity)

        // Update rate value to 2.
        exchangeRateEntity.updateRateValue(to: 2)

        // Verify that rate value was updated.
        try verifyExchangeRateData(in: exchangeRateEntity, data: exchangeRateData, baseCurrency: currencyEntity, rateValue: 2)
    }

    // Generally exhchange rate entity can not be deleted. Scanario is only checking relations between entities.
    func test_delete_exchange_rate_entity() throws {
        // Create currency entity that will be used as base currency.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: .pln))

        // Create exchange rate entity using sample data.
        let exchangeRateEntity = createExchangeRateEntity(model: .eurInPln, baseCurrency: currencyEntity)

        // Delete exchange rate entity.
        context.delete(exchangeRateEntity)

        // Verify that exchange rate entity was deleted.
        try fetchRequestShouldReturnElements(0, for: ExchangeRateEntity.self)

        // Verify that currency entity was not deleted.
        try fetchRequestShouldReturnElements(1, for: CurrencyEntity.self)

        // Save context.
        try saveContext()
    }
}

// MARK: - Steps

private extension ExchangeRateTests {
    func createExchangeRateEntity(model: ExchangeRateEntity.Model, baseCurrency: CurrencyEntity) -> ExchangeRateEntity {
        ExchangeRateEntity.create(in: context, model: model, baseCurrency: baseCurrency)
    }

    func verifyExchangeRateData(in entity: ExchangeRateEntity,
                                data: ExchangeRateEntity.Model,
                                baseCurrency: CurrencyEntity,
                                rateValue: Decimal? = nil
    ) throws {
        XCTAssertEqual(entity.code, data.code)
        XCTAssertEqual(entity.rateValue, rateValue ?? data.rateValue)
        XCTAssertEqual(entity.baseCurrency, baseCurrency)
    }
}
