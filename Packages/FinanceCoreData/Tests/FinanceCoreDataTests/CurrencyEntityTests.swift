//
//  CurrencyEntityTests.swift
//  FinanceCoreDataTests
//
//  Created by Sebastian Staszczyk on 14/11/2021.
//

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
        let currencyData = CurrencyData.eur

        // Before creating, there should not be any currencies.
        try fetchRequestShouldReturnElements(0, for: CurrencyEntity.self)

        // Create currency entity using defined data.
        let currencyEntity = createCurrencyEntity(data: currencyData)

        // After creating, there should be one currency entity.
        try fetchRequestShouldReturnElements(1, for: CurrencyEntity.self)

        // Verify that currency entity data is correct.
        try verifyCurrencyData(in: currencyEntity, data: currencyData)

        // Save context.
        try saveContext()
    }
}

private extension CurrencyEntityTests {
    func createCurrencyEntity(data: CurrencyData) -> CurrencyEntity {
        CurrencyEntity.create(in: context, currencyData: data)
    }

    func verifyCurrencyData(in entity: CurrencyEntity, data: CurrencyData) throws {
        XCTAssertEqual(entity.name, data.name)
        XCTAssertEqual(entity.code, data.code)
        XCTAssertEqual(entity.updateDate, nil)
    }
}
