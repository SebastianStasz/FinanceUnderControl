//
//  CashFlowCategoryEntity.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData
import Foundation
import SwiftUI

@objc(CashFlowCategoryEntity) public class CashFlowCategoryEntity: NSManagedObject, Entity, Deletable {
    @NSManaged private var type_: String
    @NSManaged private var icon_: String
    @NSManaged private var color_: String
    @NSManaged public private(set) var name: String
    @NSManaged public private(set) var group: CashFlowCategoryGroupEntity?
    @NSManaged public private(set) var cashFlows: Set<CashFlowEntity>

    public private(set) var icon: CashFlowCategoryIcon {
        get { .getCase(for: icon_) }
        set { icon_ = newValue.rawValue }
    }

    public private(set) var color: CashFlowCategoryColor {
        get { .getCase(for: color_) }
        set { color_ = newValue.rawValue }
    }

    public private(set) var type: CashFlowType {
        get { .getCase(for: type_) }
        set { type_ = newValue.rawValue }
    }
}

// MARK: - Public methods

public extension CashFlowCategoryEntity {

    @discardableResult
    static func createAndReturn(in context: NSManagedObjectContext, model: Model) -> CashFlowCategoryEntity {
        let category = CashFlowCategoryEntity(context: context)
        category.type = model.type
        category.edit(model: model)
        return category
    }

    static func create(in context: NSManagedObjectContext, model: Model) {
        createAndReturn(in: context, model: model)
    }

    @discardableResult
    func edit(model: Model) -> Bool {
        guard type == model.type else { return false }
        name = model.name
        icon = model.icon
        color = model.color
        return true
    }

    func delete() {
        CoreDataHelper.delete(self, canBeDeleted: {
            self.cashFlows.isEmpty
        })
    }

    static func fetchRequest(forType type: CashFlowType, group: Group? = nil) -> FetchRequest<CashFlowCategoryEntity> {
        var filters: [Filter] = [.typeIs(type)]
        if let group = group {
            filters.append(.group(group))
        }
        return CashFlowCategoryEntity.fetchRequest(filteringBy: filters, sortingBy: [.byName()])
    }

    static func getAll(from context: NSManagedObjectContext, filteringBy filters: [Filter] = []) -> [CashFlowCategoryEntity] {
        let request = CashFlowCategoryEntity.nsFetchRequest(filteringBy: filters, sortingBy: [.byName(.forward)])
        let result = try? context.fetch(request)
        return result ?? []
    }
}

// MARK: - Generated accessors for cashFlows

private extension CashFlowCategoryEntity {
    @objc(removeCashFlowsObject:) @NSManaged private func removeFromCashFlows(_ value: CashFlowEntity)
    @objc(removeCashFlows:)       @NSManaged private func removeFromCashFlows(_ values: NSSet)
    @objc(addCashFlowsObject:)    @NSManaged private func addToCashFlows(_ value: CashFlowEntity)
    @objc(addCashFlows:)          @NSManaged private func addToCashFlows(_ values: NSSet)
}

// MARK: - Sample data

public extension CashFlowCategoryEntity {
    static let carExpense = CashFlowCategoryEntity.createAndReturn(in: PersistenceController.previewEmpty.context, model: .carExpense)
}
