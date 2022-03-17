//
//  CashFlowCategoryEntityTests.swift
//  FinanceCoreDataTests
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData
import Domain
import XCTest
@testable import FinanceCoreData

final class CashFlowCategoryEntityTests: XCTestCase, CoreDataSteps {

    var context = PersistenceController.previewEmpty.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Main tests

    func test_create_cash_flow_category_entity() throws {
        // Define cash flow category data.
        let cashFlowCategoryData = CashFlowCategoryData.foodExpense

        // Before creating, there should not be any cash flow categories.
        try fetchRequestShouldReturnElements(0, for: CashFlowCategoryEntity.self)

        // Create cash flow category entity using defined data.
        let cashFlowCategoryEntity = createCashFlowCategoryEntity(data: cashFlowCategoryData)

        // After creating, there should be one cash flow category entity.
        try fetchRequestShouldReturnElements(1, for: CashFlowCategoryEntity.self)

        // Verify that cash flow category entity data is correct.
        verifyCashFlowCategoryData(in: cashFlowCategoryEntity, data: cashFlowCategoryData)

        // Save context.
        try saveContext()
    }

    func test_edit_cash_flow_category_entity() throws {
        // Create cash flow category entity.
        let category = createCashFlowCategoryEntity(data: .foodExpense)

        // Define cash flow category edited data.
        let editedData = CashFlowCategoryData.carExpense

        // Try to edit cash flow category entity using income data.
        XCTAssertFalse(category.edit(data: .workIncome))

        // Verify that cash flow category entity data has not changed.
        verifyCashFlowCategoryData(in: category, data: .foodExpense)

        // Edit created cash flow category entity using workExpense data.
        XCTAssert(category.edit(data: editedData))

        // Verify that cash flow category entity data is changed.
        verifyCashFlowCategoryData(in: category, data: editedData)

        // Save context.
        try saveContext()
    }

    func test_delete_cash_flow_category_entity() throws {
        // Create cash flow category group entity.
        let group = createCashFlowCategoryGroupEntity(data: .foodExpense)

        // Create currency entity.
        let currency = try XCTUnwrap(createCurrencyEntity(data: .eur))

        // Create cash flow category entity.
        let category = createCashFlowCategoryEntity(data: .foodExpense)

        // Add category entity to group.
        XCTAssert(group.addToCategories(category))

        // Create cash flow entity using created cash flow category entity.
        let cashFlowEntity = createCashFlowEntity(data: .sample1(currency: currency, category: category))

        // Try to delete cash flow category entity.
        XCTAssertFalse(category.delete())

        // Verify that cash flow category entity was not deleted.
        try fetchRequestShouldReturnElements(1, for: CashFlowCategoryEntity.self)

        // Delete cash flow entity.
        cashFlowEntity.delete()

        // Save context.
        try saveContext()

        // Delete cash flow category entity.
        XCTAssertTrue(category.delete())

        // Verify that cash flow category entity was deleted.
        try fetchRequestShouldReturnElements(0, for: CashFlowCategoryEntity.self)

        // Verify that cash flow category group entity was not deleted.
        try fetchRequestShouldReturnElements(1, for: CashFlowCategoryGroupEntity.self)

        // Save context.
        try saveContext()
    }

    // MARK: - Filter tests

    func test_filter_group_is_ungrouped() {
        // Create cash flow category group entity.
        let group = createCashFlowCategoryGroupEntity(data: .foodExpense)

        // Create categories and add them to the group.
        let categoryWithGroup1 = createCashFlowCategoryEntity(data: .foodExpense)
        let categoryWithGroup2 = createCashFlowCategoryEntity(data: .carExpense)
        group.addToCategories(categoryWithGroup1)
        group.addToCategories(categoryWithGroup2)

        // Create ungrouped category.
        let ungroupedCategory = createCashFlowCategoryEntity(data: .hobbyExpense)

        // Verify filtering by ungrouped categories.
        verifyUngroupedCategories([ungroupedCategory])
    }
}

// MARK: - Steps

private extension CashFlowCategoryEntityTests {

    func verifyCashFlowCategoryData(in cashFlowCategoryEntity: CashFlowCategoryEntity,
                                    data: CashFlowCategoryData,
                                    numOfCashFlows: Int = 0
    ) {
        XCTAssertEqual(cashFlowCategoryEntity.name, data.name)
        XCTAssertEqual(cashFlowCategoryEntity.icon, data.icon)
        XCTAssertEqual(cashFlowCategoryEntity.color, data.color)
        XCTAssertEqual(cashFlowCategoryEntity.type, data.type)
        XCTAssertEqual(cashFlowCategoryEntity.cashFlows.count, numOfCashFlows)
    }

    func verifyUngroupedCategories(_ categories: [CashFlowCategoryEntity]) {
        let request = CashFlowCategoryEntity.nsFetchRequest(filteringBy: [.groupIs(.ungrouped)])
        let ungroupedCategories = try! context.fetch(request) // swiftlint:disable:this force_try
        XCTAssertEqual(ungroupedCategories.count, categories.count)
        for category in ungroupedCategories {
            XCTAssert(categories.contains(category))
        }
    }
}
