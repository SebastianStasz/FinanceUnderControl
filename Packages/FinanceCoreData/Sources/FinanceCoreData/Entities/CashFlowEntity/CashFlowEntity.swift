//
//  CashFlowEntity.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData
import Foundation

@objc(CashFlowEntity)public class CashFlowEntity: NSManagedObject, Entity {
    @NSManaged public private(set) var name: String
    @NSManaged public private(set) var date: Date
    @NSManaged public private(set) var value: Double
    @NSManaged public private(set) var category: CashFlowCategoryEntity
    @NSManaged public private(set) var currency: CurrencyEntity?
}

// MARK: - Methods

public extension CashFlowEntity {

    @discardableResult static func create(in context: NSManagedObjectContext, model: Model) -> CashFlowEntity {
        let cashFlow = CashFlowEntity(context: context)
        cashFlow.name = model.name
        cashFlow.date = model.date
        cashFlow.value = model.value
        cashFlow.currency = model.currency
        cashFlow.category = model.category
        return cashFlow
    }

    func edit(usingData data: Model) {
        name = data.name
        date = data.date
        value = data.value
        if category.type == data.category.type {
            category = data.category
        }
    }

    /// Deletes cash flow  if context found.
    /// - Returns: `true` if the entity has been deleted, `false` if the entity cannot be deleted.
    func delete() -> Bool {
        guard let context = self.getContext() else { return false }
        context.delete(self)
        return true
    }
}

// MARK: - Helpers

extension CashFlowEntity: Removable {}
