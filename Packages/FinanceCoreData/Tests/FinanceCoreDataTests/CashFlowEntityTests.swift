//
//  CashFlowEntityTests.swift
//  FinanceCoreDataTests
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import XCTest
@testable import FinanceCoreData

final class CashFlowEntityTests: XCTestCase, CoreDataSteps {

    var context = PersistenceController.previewEmpty.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Tests

    func test_create_cash_flow_entity() throws {
        // Create cash flow category entity.
        let cashFlowCategoryEntity = createCashFlowCategoryEntity(data: .carExpense)

        // Create currency entity.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: .eur))

        // Define cash flow data.
        let cashFlowData = CashFlowData.sample1(currency: currencyEntity, category: cashFlowCategoryEntity)

        // Before creating, there should not be any cash flow entities.
        try fetchRequestShouldReturnElements(0, for: CashFlowEntity.self)

        // Create cash flow entity.
        let cashFlowEntity = createCashFlowEntity(data: cashFlowData)

        // After creating, there should be one cash flow entities.
        try fetchRequestShouldReturnElements(1, for: CashFlowEntity.self)

        // Verify that cash flow category entity data is correct.
        try verifyCashFlowEntityData(in: cashFlowEntity, data: cashFlowData)

        // Save context.
        try saveContext()
    }

    func test_edit_cash_flow_entity() throws {
        // Create currency entity.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: .eur))

        // Create cash flow category entity.
        let cashFlowCategoryEntity = createCashFlowCategoryEntity(data: .carExpense)

        // Create cash flow category 2 entity.
        let cashFlowCategoryEntity2 = createCashFlowCategoryEntity(data: .workPayment)

        // Create cash flow category 3 entity.
        let cashFlowCategoryEntity3 = createCashFlowCategoryEntity(data: .foodExpense)

        // Define cash flow data.
        let cashFlowData = CashFlowData.sample1(currency: currencyEntity, category: cashFlowCategoryEntity)

        // Define cash flow data 2.
        let cashFlowData2 = CashFlowData.sample1(currency: currencyEntity, category: cashFlowCategoryEntity2)

        // Define cash flow data 3.
        let cashFlowData3 = CashFlowData.sample1(currency: currencyEntity, category: cashFlowCategoryEntity3)

        // Create cash flow entity.
        let cashFlowEntity = createCashFlowEntity(data: cashFlowData)

        // Edit cash flow entity using cashFlowData2.
        cashFlowEntity.edit(usingData: cashFlowData2)

        // Verify that cash flow entity data is changed without category.
        try verifyCashFlowEntityData(in: cashFlowEntity, data: cashFlowData2, category: cashFlowCategoryEntity)

        // Edit cash flow entity using cashFlowData3.
        cashFlowEntity.edit(usingData: cashFlowData3)

        // Verify that cash flow entity data is changed.
        try verifyCashFlowEntityData(in: cashFlowEntity, data: cashFlowData3, category: cashFlowCategoryEntity3)

        // Save context.
        try saveContext()
    }

    func test_delete_cash_flow_entity() throws {
        // Create currency entity.
        let currencyEntity = try XCTUnwrap(createCurrencyEntity(data: .eur))

        // Create cash flow category entity.
        let cashFlowCategoryEntity = createCashFlowCategoryEntity(data: .carExpense)

        // Define cash flow data.
        let cashFlowData = CashFlowData.sample1(currency: currencyEntity, category: cashFlowCategoryEntity)

        // Create cash flow entity.
        let cashFlowEntity = createCashFlowEntity(data: cashFlowData)

        // Delete cash flow entity.
        cashFlowEntity.delete()

        // Verify that cash flow entity was deleted.
        try fetchRequestShouldReturnElements(0, for: CashFlowEntity.self)

        // Verify that cash flow category entity still exists.
        try fetchRequestShouldReturnElements(1, for: CashFlowCategoryEntity.self)

        // Verify that cash flows are empty in cash flow category entity.
        XCTAssert(cashFlowCategoryEntity.cashFlows.isEmpty)

        // Verify that currency entity still exists.
        try fetchRequestShouldReturnElements(1, for: CurrencyEntity.self)
    }
}

// MARK: - Steps

private extension CashFlowEntityTests {
    func verifyCashFlowEntityData(in cashFlowEntity: CashFlowEntity, data: CashFlowData, category: CashFlowCategoryEntity? = nil) throws {
        XCTAssertEqual(cashFlowEntity.name, data.name)
        XCTAssertEqual(cashFlowEntity.date, data.date)
        XCTAssertEqual(cashFlowEntity.value, data.value)
        XCTAssertEqual(cashFlowEntity.category, category ?? data.category)
    }
}
