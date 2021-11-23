//
//  CoreDataSteps.swift
//  FinanceDoreDataTests
//
//  Created by Sebastian Staszczyk on 14/11/2021.
//

import CoreData
import XCTest
@testable import FinanceCoreData

protocol CoreDataSteps {
    var context: NSManagedObjectContext { get set }
}

extension CoreDataSteps {
    func createCurrencyEntity(data: CurrencyData) -> CurrencyEntity {
        CurrencyEntity.create(in: context, currencyData: data)
    }

    @discardableResult func fetchRequestShouldReturnElements<T: NSManagedObject>(_ amount: Int, for entity: T.Type) throws -> [T] {
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
        }
        catch let error {
            XCTFail("Saving context error: \(error)")
            return false
        }
    }
}