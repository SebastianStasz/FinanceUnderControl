//
//  CashFlowCategoryGroupEntityTests.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//

import Foundation
import XCTest
@testable import FinanceCoreData

final class CashFlowCategoryGroupEntityTests: XCTestCase, CoreDataSteps {
    typealias Model = CashFlowCategoryGroupEntity.Model

    var context = PersistenceController.previewEmpty.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Main tests

    func test_create_cash_flow_category_group_entity() throws {
        // Define cash flow category group data.
        let model = Model.foodExpense

        // Before creating, there should not be any cash flow category groups.
        try fetchRequestShouldReturnElements(0, for: CashFlowCategoryGroupEntity.self)

        // Create cash flow category group entity using defined data.
        let group = createCashFlowCategoryGroupEntity(model: model)

        // After creating, there should be one cash flow category group entity.
        try fetchRequestShouldReturnElements(1, for: CashFlowCategoryGroupEntity.self)

        // Verify that cash flow category group entity data is correct.
        verifyCashFlowCategoryGroupData(in: group, model: model)

        // Save context.
        try saveContext()
    }

    func test_edit_cash_flow_category_group_entity() throws {
        // Create expense cash flow category group entity.
        let group = createCashFlowCategoryGroupEntity(model: .foodExpense)

        // Define cash flow category group edited data.
        let editedData = Model.carExpense

        // Try to edit cash flow category group entity using income group data.
        XCTAssertFalse(group.edit(model: .workIncome))

        // Verify that cash flow category group entity data has not changed.
        verifyCashFlowCategoryGroupData(in: group, model: .foodExpense)

        // Edit cash flow category group entity using edited data.
        XCTAssert(group.edit(model: editedData))

        // Verify that cash flow category group entity data is changed.
        verifyCashFlowCategoryGroupData(in: group, model: editedData)

        // Save context.
        try saveContext()
    }

    func test_adding_category_to_cash_flow_category_group_entity() throws {
        // Create expense cash flow category.
        let expenseCategory = createCashFlowCategoryEntity(data: .foodExpense)

        // Create income cash flow category.
        let incomeCategory = createCashFlowCategoryEntity(data: .workIncome)

        // Create expense cash flow category group entity.
        let group = createCashFlowCategoryGroupEntity(model: .foodExpense)

        // Try to add income category to expense cash flow category group entity.
        XCTAssertFalse(group.addToCategories(incomeCategory))

        // Group should not contains any categories.
        verifyGroupDoesNotContainAnyCategory(group)

        // Add expense category to expense cash flow category group entity.
        XCTAssert(group.addToCategories(expenseCategory))

        // Veriify that expense category was added.
        verifyGroupContainsCategories(group, categories: [expenseCategory])
    }

    func test_removing_category_from_cash_flow_category_group_entity() throws {
        // Create first cash flow category.
        let firstCategory = createCashFlowCategoryEntity(data: .foodExpense)

        // Create second cash flow category.
        let secondCategory = createCashFlowCategoryEntity(data: .carExpense)

        // Create cash flow category group entity.
        let group = createCashFlowCategoryGroupEntity(model: .foodExpense)

        // Add categories to cash flow category group.
        XCTAssert(group.addToCategories(firstCategory))
        XCTAssert(group.addToCategories(secondCategory))

        // Remove first category from cash flow category group.
        group.removeFromCategories(firstCategory)

        // Verify that first category was removed from cash flow category group entity.
        verifyGroupContainsCategories(group, categories: [secondCategory])

        // Remove second category from cash flow category group.
        group.removeFromCategories(secondCategory)

        // Group should not contains any categories.
        verifyGroupDoesNotContainAnyCategory(group)
    }

    func test_delete_cash_flow_category_group_entity() throws {
        // Create cash flow category.
        let category = createCashFlowCategoryEntity(data: .carExpense)

        // Create cash flow category group entity.
        let group = createCashFlowCategoryGroupEntity(model: .foodExpense)

        // Add category to cash flow category group entity.
        XCTAssert(group.addToCategories(category))

        // Delete created cash flow category group entity.
        XCTAssert(group.delete())

        // Verify that cash flow category group entity was deleted.
        try fetchRequestShouldReturnElements(0, for: CashFlowCategoryGroupEntity.self)

        // Verify that category still exists.
        try fetchRequestShouldReturnElements(1, for: CashFlowCategoryEntity.self)

        // Save context.
        try saveContext()
    }
}

// MARK: - Steps

private extension CashFlowCategoryGroupEntityTests {

    func verifyCashFlowCategoryGroupData(in group: CashFlowCategoryGroupEntity, model: Model) {
        XCTAssertEqual(group.type, model.type)
        XCTAssertEqual(group.name, model.name)
    }

    func verifyGroupDoesNotContainAnyCategory(_ group: CashFlowCategoryGroupEntity) {
        XCTAssertEqual(group.categories.count, 0)
    }

    func verifyGroupContainsCategories(_ group: CashFlowCategoryGroupEntity, categories: [CashFlowCategoryEntity]) {
        XCTAssertEqual(group.categories.count, categories.count)
        for category in group.categories {
            XCTAssert(categories.contains(category))
        }
    }
}
