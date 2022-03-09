//
//  CashFlowCategoryGroupEntity.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//
//

import Foundation
import CoreData

@objc(CashFlowCategoryGroupEntity) public class CashFlowCategoryGroupEntity: NSManagedObject, Entity {
    @NSManaged public private(set) var name: String?
    @NSManaged public private(set) var categories: NSSet?
}

// MARK: Generated accessors for categories

extension CashFlowCategoryGroupEntity {

    @objc(addCategoriesObject:)
    @NSManaged private func addToCategories(_ value: CashFlowCategoryEntity)

    @objc(removeCategoriesObject:)
    @NSManaged private func removeFromCategories(_ value: CashFlowCategoryEntity)

    @objc(addCategories:)
    @NSManaged private func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged private func removeFromCategories(_ values: NSSet)

}
