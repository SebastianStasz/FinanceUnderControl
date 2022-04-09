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

    /// Creates a cash flow category group in the given context using the model provided.
    /// - Parameters:
    ///   - context: Context in which the entity will be created.
    ///   - model: Model that will be used to create the enity.
    /// - Returns: Created cash flow category group entity.
    @discardableResult
    static func createAndReturn(in context: NSManagedObjectContext, model: Model) -> CashFlowCategoryGroupEntity {
        let group = CashFlowCategoryGroupEntity(context: context)
        group.type = model.type
        group.edit(model: model)
        return group
    }

    static func create(in context: NSManagedObjectContext, model: Model) {
        createAndReturn(in: context, model: model)
    }

    /// Edists a cash flow category group using the model provided if the model is of the same type as the group.
    /// - Parameter model: Model that will be used to edit the entity.
    /// - Returns: `true` if the entity has been edited `false` if the entity cannot be edited.
    @discardableResult
    func edit(model: Model) -> Bool {
        guard type == model.type else { return false }
        let categoriesToRemove = categories.filter { model.categories.notContains($0) }
        let categoriesToAdd = model.categories.filter { categories.notContains($0) }
        name = model.name
        removeFromCategories_(entities: NSSet(array: categoriesToRemove))
        addToCategories(categoriesToAdd)
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

    /// /// Adds a cash flow categories to a cash flow category group if the categories are of the same type as the group.
    /// - Parameter categories: Categories to be added to the group.
    func addToCategories(_ categories: [CashFlowCategoryEntity]) {
        for category in categories {
            addToCategories(category)
        }
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

    static func getAll(from controller: PersistenceController) async -> [CashFlowCategoryGroupEntity.DataModel] {
        let result = try? await controller.asyncFetch(request: CashFlowCategoryGroupEntity.nsFetchRequest(sortingBy: [.byName()]))
        return result ?? []
    }

    static func getAll(from context: NSManagedObjectContext) -> [CashFlowCategoryGroupEntity] {
        let request = CashFlowCategoryGroupEntity.nsFetchRequest(sortingBy: [.byName()])
        let result = try? context.fetch(request)
        return result ?? []
    }
}

// MARK: - Helpers

extension CashFlowCategoryGroupEntity: Deletable {}

// MARK: - Generated accessors for categories

private extension CashFlowCategoryGroupEntity {
    @objc(removeCategories_Object:) @NSManaged func removeFromCategories_(entity: CashFlowCategoryEntity)
    @objc(removeCategories_:)       @NSManaged func removeFromCategories_(entities: NSSet)
    @objc(addCategories_Object:)    @NSManaged func addToCategories_(entity: CashFlowCategoryEntity)
    @objc(addCategories_:)          @NSManaged func addToCategories_(entities: NSSet)
}

extension PersistenceController {
    func asyncFetch<E, R>(request: NSFetchRequest<E>) async throws -> [R] where E: Storable, R == E.EntityDataModel {
        print("AsyncFetch - Is main thread: \(Thread.isMainThread)")
        return try context.fetch(request).compactMap { $0.dataModel }
    }
}
