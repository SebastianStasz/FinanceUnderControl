//
//  CashFlowCategoryGroupEntity.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 09/03/2022.
//
//
import CoreData
import Foundation
import SSUtils

@objc(CashFlowCategoryGroupEntity) public class CashFlowCategoryGroupEntity: NSManagedObject, Entity {
    @NSManaged private var type_: String
    @NSManaged public private(set) var name: String?
    @NSManaged public private(set) var categories: NSSet?

    public private(set) var type: CashFlowType {
        get { .getCase(for: type_) }
        set { type_ = newValue.rawValue }
    }
}

// MARK: - Public methods

public extension CashFlowCategoryGroupEntity {

    @discardableResult
    static func create(in context: NSManagedObjectContext, data: CashFlowCategoryGroupData) -> CashFlowCategoryGroupEntity {
        let group = CashFlowCategoryGroupEntity(context: context)
        group.type = data.type
        group.edit(data: data)
        return group
    }

    func edit(data: CashFlowCategoryGroupData) {
        name = data.name
    }
}

// MARK: - Private methods

private extension CashFlowCategoryGroupEntity {

}

// MARK: - Generated accessors for categories

private extension CashFlowCategoryGroupEntity {
    @objc(removeCategoriesObject:) @NSManaged func removeFromCategories(_ value: CashFlowCategoryEntity)
    @objc(removeCategories:)       @NSManaged func removeFromCategories(_ values: NSSet)
    @objc(addCategoriesObject:)    @NSManaged func addToCategories(_ value: CashFlowCategoryEntity)
    @objc(addCategories:)          @NSManaged func addToCategories(_ values: NSSet)
}
