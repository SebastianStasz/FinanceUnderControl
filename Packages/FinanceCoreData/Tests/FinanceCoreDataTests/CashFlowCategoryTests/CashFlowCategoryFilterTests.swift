//
//  CashFlowCategoryFilterTests.swift
//  FinanceCoreDataTests
//
//  Created by sebastianstaszczyk on 17/04/2022.
//

import CoreData
import XCTest
@testable import FinanceCoreData

final class CashFlowCategoryFilterTests: XCTestCase {
    typealias Entity = CashFlowCategoryEntity
    typealias Model = Entity.Model

    private var context = PersistenceController.previewEmpty.context

    private let models = [
        Model(name: "Category1", icon: .circleFill, type: .income),
        Model(name: "Category1", icon: .circleFill, type: .expense),
        Model(name: "Category2", icon: .airplane, type: .income),
    ]

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Tests

    func test_type_filter() throws {
        let categories = models.map  { Entity.createAndReturn(in: context, model: $0) }
        let result = Entity.getAll(from: context, filters: .type(.income))

        XCTAssertEqual(result.count, 2)
        XCTAssert(result.contains(categories[0]))
        XCTAssert(result.contains(categories[2]))
    }

    func test_ungrouped_filter() throws {
        let categories = [
            Model(name: "Category1", icon: .circleFill, type: .expense),
            Model(name: "Category1", icon: .circleFill, type: .income),
            Model(name: "Category2", icon: .airplane, type: .expense),
        ]
        .map  { Entity.createAndReturn(in: context, model: $0) }
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Group1", type: .income, color: .green, categories: [categories[1]]))
        let result = Entity.getAll(from: context, filters: .ungrouped)

        XCTAssertEqual(result.count, 2)
        XCTAssert(result.contains(categories[0]))
        XCTAssert(result.contains(categories[2]))
    }

    func test_group_name_is_not_filter() throws {
        let categories = [
            Model(name: "Category1", icon: .circleFill, type: .expense),
            Model(name: "Category1", icon: .circleFill, type: .income),
            Model(name: "Category2", icon: .airplane, type: .expense),
        ]
        .map  { Entity.createAndReturn(in: context, model: $0) }
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Group1", type: .income, color: .green, categories: [categories[1]]))
        CashFlowCategoryGroupEntity.create(in: context, model: .init(name: "Group2", type: .expense, color: .red, categories: [categories[0]]))
        let result = Entity.getAll(from: context, filters: .groupNameIsNot("Group2"))

        XCTAssertEqual(result.count, 2)
        XCTAssert(result.contains(categories[1]))
        XCTAssert(result.contains(categories[2]))
    }
}

