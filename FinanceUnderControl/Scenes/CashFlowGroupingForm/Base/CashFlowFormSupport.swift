//
//  CashFlowFormSupport.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import CoreData
import Foundation
import FinanceCoreData
import SSValidation

protocol CashFlowFormSupport: Entity, Deletable {
    associatedtype FormModel: CashFlowGroupingFormModel where FormModel.Ent == Self

    var formModel: FormModel { get }

    static func namesInUse(from context: NSManagedObjectContext, forType type: CashFlowType) -> [String]
    static func create(in context: NSManagedObjectContext, model: Model)
    @discardableResult func edit(model: Model) -> Bool
}

extension CashFlowFormSupport {
    static func namesInUse(from context: NSManagedObjectContext, forType type: CashFlowType) -> [String] {
        []
    }
}

// MARK: - Compatibility

extension CashFlowCategoryEntity: CashFlowFormSupport {
    var formModel: FormModel {
        .init(name: name, type: type, icon: icon, color: color)
    }

    static func namesInUse(from context: NSManagedObjectContext, forType type: CashFlowType) -> [String] {
        CashFlowCategoryEntity.getAll(from: context, filteringBy: [.typeIs(type)]).map { $0.name }
    }
}

extension CashFlowCategoryGroupEntity: CashFlowFormSupport {
    var formModel: FormModel {
        .init(name: name, type: type, categories: categories)
    }

    static func namesInUse(from context: NSManagedObjectContext, forType type: CashFlowType) -> [String] {
        CashFlowCategoryGroupEntity.getAll(from: context, filterBy: [.typeIs(type)]).map { $0.name }
    }
}

extension CashFlowEntity: CashFlowFormSupport {
    var formModel: FormModel {
        .init(date: date, name: name, value: value, currency: currency, category: category, type: category.type)
    }
}
