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
    @NSManaged public private(set) var category: CashFlowCategoryEntity
}

// MARK: - Methods

public extension CashFlowEntity {

    @discardableResult static func create(in context: NSManagedObjectContext, data: CashFlowData) -> CashFlowEntity {
        let cashFlow = CashFlowEntity(context: context)
        cashFlow.edit(usingData: data)
        return cashFlow
    }

    func edit(usingData data: CashFlowData) {
        name = data.name
        category = data.category
    }
}

// MARK: - Helpers

extension CashFlowEntity: Removable {}
