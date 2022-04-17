//
//  CurrencyTests.swift
//  FinanceCoreDataTests
//
//  Created by Sebastian Staszczyk on 14/11/2021.
//

import Domain
import XCTest
@testable import FinanceCoreData

final class CurrencyTests: XCTestCase, CoreDataSteps {
    typealias Model = CurrencyEntity.Model

    var context = PersistenceController.previewEmpty.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Tests

    func test_create_currency_entity() throws {
        // Define currency data.
        let currencyData = Model.eur

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
        let currencyData = Model.pln

        // Create currency entity using defined data.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: currencyData))

        // Define exchange rates data.
        let exchangeRatesData: [ExchangeRateEntity.Model] = [.eurInPln, .usdInPln]

        // Add exchange rates to currency entity.
        currencyEntity.addExchangeRates(exchangeRatesData)

        // Verify currency data is correct.
        try verifyCurrencyData(in: currencyEntity, data: currencyData, wasUpdated: false, exchangeRates: exchangeRatesData)
    }

    func test_update_exchange_rates() throws {
        // Define currency data.
        let currencyData = Model.pln

        // Create currency entity using defined data.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: currencyData))

        // Define exchange rates data.
        let exchangeRatesData: [ExchangeRateEntity.Model] = [.eurInPln, .usdInPln]

        // Add exchange rates to currency entity.
        currencyEntity.addExchangeRates(exchangeRatesData)

        // Define exchange rates data.
        let exchangeRatesData2: [ExchangeRateEntity.Model] = [.eurInPln2, .usdInPln2]

        // Update exchange rates.
        currencyEntity.updateExchangeRates(with: exchangeRatesData2)

        // Verify currency data is correct.
        try verifyCurrencyData(in: currencyEntity, data: currencyData, wasUpdated: true, exchangeRates: exchangeRatesData2)
    }

    // Generally currency entity can not be deleted. Scanario is only checking relations between entities.
    func test_delete_currency_entity() throws {
        // Create currency entity using sample data.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: .pln))

        // Create cash flow category entity.
        let cashFlowCategoryEntity = createCashFlowCategoryEntity(data: .workIncome)

        // Create cash flow entity.
        createCashFlowEntity(data: .sample1(currency: currencyEntity, category: cashFlowCategoryEntity))

        // Define exchange rates data.
        let exchangeRatesData: [ExchangeRateEntity.Model] = [.eurInPln, .usdInPln]

        // Add exchange rates to currency entity.
        currencyEntity.addExchangeRates(exchangeRatesData)

        // Delete currency entity.
        context.delete(currencyEntity)

        // Verify that currency entity was deleted.
        try fetchRequestShouldReturnElements(0, for: CurrencyEntity.self)

        // Verify that exchange rates related to this entity were deleted.
        try fetchRequestShouldReturnElements(0, for: ExchangeRateEntity.self)

        // Verify that cash flow entity was not deleted.
        try fetchRequestShouldReturnElements(1, for: CashFlowEntity.self)
    }
}

// MARK: - Steps

private extension CurrencyTests {

    func verifyCurrencyData(in entity: CurrencyEntity,
                            data: Model,
                            wasUpdated: Bool,
                            exchangeRates: [ExchangeRateEntity.Model] = []
    ) throws {
        XCTAssertEqual(entity.name, data.nameKey)
        XCTAssertEqual(entity.code, data.code)
        wasUpdated ? XCTAssertNotNil(entity.updateDateString) : XCTAssertNil(entity.updateDateString)
        XCTAssertEqual(entity.exchangeRates.count, exchangeRates.count)
        for exchangeRate in entity.exchangeRates {
            XCTAssert(exchangeRates.contains(where: {
                $0.code == exchangeRate.code && $0.rateValue == exchangeRate.rateValue
            }))
        }
    }
}
