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
    associatedtype FormModel: CashFlowFormModel where FormModel.Ent == Self

    var formModel: FormModel { get }

    static func namesInUse(from context: NSManagedObjectContext) -> [String]
    static func create(in context: NSManagedObjectContext, model: Model)
    @discardableResult func edit(model: Model) -> Bool
}

// MARK: - Compatibility

extension CashFlowCategoryEntity: CashFlowFormSupport {
    var formModel: FormModel {
        .init(name: name, type: type, icon: icon, color: color)
    }

    static func namesInUse(from context: NSManagedObjectContext) -> [String] {
        CashFlowCategoryEntity.getAll(from: context).map { $0.name }
    }
}

extension CashFlowCategoryGroupEntity: CashFlowFormSupport {
    var formModel: FormModel {
        .init(name: name, type: type)
    }

    static func namesInUse(from context: NSManagedObjectContext) -> [String] {
        CashFlowCategoryGroupEntity.getAll(from: context).map { $0.name }
    }
}
