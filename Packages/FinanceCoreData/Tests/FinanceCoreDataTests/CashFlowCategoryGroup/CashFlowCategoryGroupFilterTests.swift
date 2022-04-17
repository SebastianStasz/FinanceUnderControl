//
//  CashFlowCategoryGroupFilterTests.swift
//  FinanceCoreDataTests
//
//  Created by sebastianstaszczyk on 17/04/2022.
//

import CoreData
import XCTest
@testable import FinanceCoreData

final class CashFlowCategoryGroupFilterTests: XCTestCase {
    typealias Entity = CashFlowCategoryGroupEntity
    typealias Model = Entity.Model

    private var context = PersistenceController.previewEmpty.context

    private let models = [
        Model(name: "Work", type: .income, color: .mint),
        Model(name: "Work", type: .expense, color: .mint),
        Model(name: "Work2", type: .income, color: .orange),
        Model(name: "Restaurants & dinning", type: .expense, color: .red)
    ]

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Tests

    func test_name_filter() throws {
        let groups = models.map  { Entity.createAndReturn(in: context, model: $0) }
        let result = Entity.getAll(from: context, filterBy: .name("Work"))

        XCTAssertEqual(result.count, 2)
        XCTAssert(result.contains(groups[0]))
        XCTAssert(result.contains(groups[1]))
    }

    func test_type_filter() throws {
        let groups = models.map  { Entity.createAndReturn(in: context, model: $0) }
        let result = Entity.getAll(from: context, filterBy: .type(.income))

        XCTAssertEqual(result.count, 2)
        XCTAssert(result.contains(groups[0]))
        XCTAssert(result.contains(groups[2]))
    }

    func test_name_and_type_filter() throws {
        let groups = models.map  { Entity.createAndReturn(in: context, model: $0) }
        let result = Entity.getAll(from: context, filterBy: .name("Work"), .type(.income))

        XCTAssertEqual(result.count, 1)
        XCTAssert(result.contains(groups[0]))
    }
}
