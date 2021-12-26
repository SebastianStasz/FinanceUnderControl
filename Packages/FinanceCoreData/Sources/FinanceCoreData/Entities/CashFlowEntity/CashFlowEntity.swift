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
}

// MARK: - Methods

public extension CashFlowEntity {

    @discardableResult static func create(in context: NSManagedObjectContext, data: CashFlowData) -> CashFlowEntity {
        let cashFlow = CashFlowEntity(context: context)
        cashFlow.name = data.name
        cashFlow.date = data.date
        cashFlow.value = data.value
        cashFlow.category = data.category
        return cashFlow
    }

    func edit(usingData data: CashFlowData) {
        name = data.name
        date = data.date
        value = data.value
        if category.type == data.category.type {
            category = data.category
        }
    }
}

// MARK: - Helpers

extension CashFlowEntity: Removable {}
