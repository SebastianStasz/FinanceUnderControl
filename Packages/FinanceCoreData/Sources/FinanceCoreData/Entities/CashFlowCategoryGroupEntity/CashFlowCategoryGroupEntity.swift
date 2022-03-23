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
import SwiftUI

@objc(CashFlowCategoryGroupEntity) public class CashFlowCategoryGroupEntity: NSManagedObject, Entity {
    @NSManaged private var type_: String
    @NSManaged private var categories_: NSSet
    @NSManaged public private(set) var name: String

    public var categories: [CashFlowCategoryEntity] {
        categories_.compactMap { $0 as? CashFlowCategoryEntity }
    }

    public private(set) var type: CashFlowType {
        get { .getCase(for: type_) }
        set { type_ = newValue.rawValue }
    }
}

// MARK: - Public methods

public extension CashFlowCategoryGroupEntity {

    /// Creates a cash flow category group in the given context using the data provided.
    /// - Parameters:
    ///   - context: Context in which the entity will be created.
    ///   - data: Data that will be used to create the enity.
    /// - Returns: Created cash flow category group entity.
    @discardableResult
    static func create(in context: NSManagedObjectContext, model: Model) -> CashFlowCategoryGroupEntity {
        let group = CashFlowCategoryGroupEntity(context: context)
        group.type = model.type
        group.edit(model: model)
        return group
    }

    /// Edists a cash flow category group using the data provided if the data is of the same type as the group.
    /// - Parameter data: Data that will be used to edit the entity.
    /// - Returns: `true` if the entity has been edited `false` if the entity cannot be edited.
    @discardableResult
    func edit(model: Model) -> Bool {
        guard type == model.type else { return false }
        name = model.name
        return true
    }

    /// Deletes cash flow category if context found.
    /// - Returns: `true` if the entity has been deleted, `false` if the entity cannot be deleted.
    func delete() -> Bool {
        guard let context = self.getContext() else { return false }
        context.delete(self)
        return true
    }

    /// Adds a cash flow category to a cash flow category group if the category is of the same type as the group.
    /// - Parameter category: Category to be added to the group.
    /// - Returns: `true` if the category has been added, `false` if the category cannot be added.
    @discardableResult
    func addToCategories(_ category: CashFlowCategoryEntity) -> Bool {
        guard type == category.type else { return false }
        addToCategories_(entity: category)
        return true
    }

    /// Removes a cash flow category from the cash flow category group.
    /// - Parameter category: Category to be removed from the group.
    func removeFromCategories(_ category: CashFlowCategoryEntity) {
        removeFromCategories_(entity: category)
    }

    /// Returns `FetchRequest` with `CashFlowCategoryGroupEntity` of provided `CashFlowType`, sorted by name in ascending order.
    /// - Parameter type: Type of cash flow.
    /// - Returns: `FetchRequest` with `CashFlowCategoryGroupEntity`.
    static func fetchRequest(forType type: CashFlowType) -> FetchRequest<CashFlowCategoryGroupEntity> {
        CashFlowCategoryGroupEntity.fetchRequest(filteringBy: [.typeIs(type)], sortingBy: [.byName()])
    }

    static func getAll(from context: NSManagedObjectContext) -> [CashFlowCategoryGroupEntity] {
        let request = CashFlowCategoryGroupEntity.nsFetchRequest(sortingBy: [.byName()])
        let result = try? context.fetch(request)
        return result ?? []
    }
}

// MARK: - Private methods

private extension CashFlowCategoryGroupEntity {

}

// MARK: - Generated accessors for categories

private extension CashFlowCategoryGroupEntity {
    @objc(removeCategories_Object:) @NSManaged func removeFromCategories_(entity: CashFlowCategoryEntity)
    @objc(removeCategories_:)       @NSManaged func removeFromCategories_(entities: NSSet)
    @objc(addCategories_Object:)    @NSManaged func addToCategories_(entity: CashFlowCategoryEntity)
    @objc(addCategories_:)          @NSManaged func addToCategories_(entities: NSSet)
}
