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
    @NSManaged public private(set) var name: String
    @NSManaged public private(set) var categories: NSSet

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

    func delete() -> Bool {
        guard let context = self.getContext() else { return false }
        context.delete(self)
        return true
    }

    func addToCategories(_ category: CashFlowCategoryEntity) -> Bool {
        guard type == category.type else { return false }
        addToCategories(entity: category)
        return true
    }

    func removeFromCategories(_ category: CashFlowCategoryEntity) {
        removeFromCategories(entity: category)
    }
}

// MARK: - Private methods

private extension CashFlowCategoryGroupEntity {

}

// MARK: - Generated accessors for categories

private extension CashFlowCategoryGroupEntity {
    @objc(removeCategoriesObject:) @NSManaged func removeFromCategories(entity: CashFlowCategoryEntity)
    @objc(removeCategories:)       @NSManaged func removeFromCategories(entities: NSSet)
    @objc(addCategoriesObject:)    @NSManaged func addToCategories(entity: CashFlowCategoryEntity)
    @objc(addCategories:)          @NSManaged func addToCategories(entities: NSSet)
}
