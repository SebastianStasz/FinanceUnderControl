//
//  CashFlowCategoryEntity.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData
import Foundation
import SwiftUI

@objc(CashFlowCategoryEntity) public class CashFlowCategoryEntity: NSManagedObject, Entity {
    @NSManaged private var type_: String
    @NSManaged private var icon_: String
    @NSManaged private var color_: String
    @NSManaged public private(set) var name: String
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
    static func create(in context: NSManagedObjectContext, data: CashFlowCategoryData) -> CashFlowCategoryEntity {
        let category = CashFlowCategoryEntity(context: context)
        category.type = data.type
        category.edit(data: data)
        return category
    }

    @discardableResult
    func edit(data: CashFlowCategoryData) -> Bool {
        guard type == data.type else { return false }
        name = data.name
        icon = data.icon
        color = data.color
        return true
    }

    func delete() -> Bool {
        guard let context = self.getContext(), self.cashFlows.isEmpty else { return false }
        context.delete(self)
        return true
    }

    static func fetchRequest(forType type: CashFlowType) -> FetchRequest<CashFlowCategoryEntity> {
        let sort = [CashFlowCategoryEntity.Sort.byName(.forward).nsSortDescriptor]
        let filter = CashFlowCategoryEntity.Filter.typeIs(type).nsPredicate
        return FetchRequest<CashFlowCategoryEntity>(sortDescriptors: sort, predicate: filter)
    }

    static func getAll(from context: NSManagedObjectContext) -> [CashFlowCategoryEntity] {
        let request = CashFlowCategoryEntity.nsFetchRequest(sortingBy: [.byName(.forward)])
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
