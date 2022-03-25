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

protocol CashFlowFormSupport: Entity {
    associatedtype Build: CashFlowGroupingFormModel where Build.Ent == Self

    var build: Build { get }

    static func namesInUse(from context: NSManagedObjectContext) -> [String]
    static func create(in context: NSManagedObjectContext, model: Model)
    @discardableResult func edit(model: Model) -> Bool
}

// MARK: - Compatibility

extension CashFlowCategoryEntity: CashFlowFormSupport {
    var build: Build {
        .init(name: name, type: type, icon: icon, color: color)
    }

    static func namesInUse(from context: NSManagedObjectContext) -> [String] {
        CashFlowCategoryEntity.getAll(from: context).map { $0.name }
    }
}

extension CashFlowCategoryGroupEntity: CashFlowFormSupport {
    var build: Build {
        .init(name: name, type: type, categories: categories)
    }

    static func namesInUse(from context: NSManagedObjectContext) -> [String] {
        CashFlowCategoryGroupEntity.getAll(from: context).map { $0.name }
    }
}
