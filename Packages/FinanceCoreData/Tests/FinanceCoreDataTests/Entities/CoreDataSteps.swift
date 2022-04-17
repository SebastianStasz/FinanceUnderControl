//
//  CoreDataSteps.swift
//  FinanceDoreDataTests
//
//  Created by Sebastian Staszczyk on 14/11/2021.
//

import Domain
import CoreData
import XCTest
@testable import FinanceCoreData

protocol CoreDataSteps {
    var context: NSManagedObjectContext { get set }
}

extension CoreDataSteps {

    // MARK: - Creating entities

    @discardableResult
    func createCurrencyEntity(data: CurrencyEntity.Model) -> CurrencyEntity? {
        CurrencyEntity.createAndReturn(in: context, model: data)
    }

    @discardableResult
    func createCashFlowEntity(data: CashFlowEntity.Model) -> CashFlowEntity {
        CashFlowEntity.createAndReturn(in: context, model: data)
    }

    @discardableResult
    func createCashFlowCategoryGroupEntity(model: CashFlowCategoryGroupEntity.Model) -> CashFlowCategoryGroupEntity {
        CashFlowCategoryGroupEntity.createAndReturn(in: context, model: model)
    }

    @discardableResult
    func createCashFlowCategoryEntity(data: CashFlowCategoryEntity.Model) -> CashFlowCategoryEntity {
        CashFlowCategoryEntity.createAndReturn(in: context, model: data)
    }

    // MARK: - Other

    @discardableResult
    func fetchRequestShouldReturnElements<T: NSManagedObject>(_ amount: Int, for entity: T.Type) throws -> [T] {
        let request: NSFetchRequest<T> = T.nsFetchRequest()
        do {
            let entities = try context.fetch(request)
            XCTAssertEqual(entities.count, amount)
            return entities
        } catch {
            XCTFail("Failed to fetch: \"\(T.description())\"")
            return []
        }
    }

    func saveContext() throws {
        XCTAssert(savePreviewContext())
    }

    private func savePreviewContext() -> Bool {
        do {
            try context.save()
            return true
        } catch let error {
            XCTFail("Saving context error: \(error)")
            return false
        }
    }
}
