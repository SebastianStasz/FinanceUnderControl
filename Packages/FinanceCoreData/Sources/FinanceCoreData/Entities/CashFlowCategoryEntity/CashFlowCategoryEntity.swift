//
//  CashFlowCategoryEntity.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData
import Foundation

@objc(CashFlowCategoryEntity) public class CashFlowCategoryEntity: NSManagedObject, Entity {
    @NSManaged public var name: String?
    @NSManaged public var type_: String?
    @NSManaged public var cashFlows: NSSet?
}

// MARK: Generated accessors for cashFlows
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

extension CashFlowCategoryEntity : Identifiable {}
