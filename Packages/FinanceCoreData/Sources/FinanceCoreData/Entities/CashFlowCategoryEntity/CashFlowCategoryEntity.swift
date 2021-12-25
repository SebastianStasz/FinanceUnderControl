//
//  CashFlowCategoryEntity.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData
import Foundation

@objc(CashFlowCategoryEntity) public class CashFlowCategoryEntity: NSManagedObject, Entity {
    @NSManaged private var type_: String
    @NSManaged public private(set) var name: String
    @NSManaged public private(set) var cashFlows: Set<CashFlowEntity>

    public private(set) var type: CashFlowCategoryType {
        get { .getCase(for: type_) }
        set { type_ = newValue.rawValue }
    }
}

// MARK: - Methods

public extension CashFlowCategoryEntity {

    @discardableResult static func create(in context: NSManagedObjectContext, data: CashFlowCategoryData) -> CashFlowCategoryEntity {
        let category = CashFlowCategoryEntity(context: context)
        category.type = data.type
        category.edit(name: data.name)
        return category
    }

    func edit(name: String) {
        self.name = name
    }

    func delete() -> Bool {
        guard let context = self.getContext(), self.cashFlows.isEmpty else { return false }
        context.delete(self)
        return true
    }
}

// MARK: - Generated accessors for cashFlows

extension CashFlowCategoryEntity {

    @objc(addCashFlowsObject:)
    @NSManaged public func addToCashFlows(_ value: CashFlowEntity)

    @objc(removeCashFlowsObject:)
    @NSManaged public func removeFromCashFlows(_ value: CashFlowEntity)

    @objc(addCashFlows:)
    @NSManaged public func addToCashFlows(_ values: NSSet)

    @objc(removeCashFlows:)
    @NSManaged public func removeFromCashFlows(_ values: NSSet)

}
