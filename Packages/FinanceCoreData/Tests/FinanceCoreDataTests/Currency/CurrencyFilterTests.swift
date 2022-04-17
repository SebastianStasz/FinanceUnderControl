//
//  CurrencyFilterTests.swift
//  FinanceCoreDataTests
//
//  Created by sebastianstaszczyk on 17/04/2022.
//

import CoreData
import XCTest
@testable import FinanceCoreData

final class CurrencyFilterTests: XCTestCase {
    typealias Entity = CurrencyEntity
    typealias Model = Entity.Model

    private var context = PersistenceController.previewEmpty.context

    private let models = [
        Model(code: "PLN", name: "Polish Zloty"),
        Model(code: "GBP", name: "British pound sterling"),
        Model(code: "USD", name: "United States dollar"),
    ]

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Tests

    func test_name_filter() throws {
        let currencies = models.map  { Entity.createAndReturn(in: context, model: $0) }
        let result = Entity.get(withCode: "PLN", from: context)

        XCTAssertEqual(result, currencies[0])
    }

    func test_code_contains_filter() throws {
        let currencies = models.map  { Entity.createAndReturn(in: context, model: $0)! }
        let result = Entity.getAll(from: context, filters: .codeContains("P"))

        XCTAssertEqual(result.count, 2)
        XCTAssert(result.contains(currencies[0]))
        XCTAssert(result.contains(currencies[1]))
    }
}

