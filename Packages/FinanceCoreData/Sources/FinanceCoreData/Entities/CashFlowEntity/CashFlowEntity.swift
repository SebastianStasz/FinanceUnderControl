//
//  CashFlowEntity.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import CoreData
import Foundation

@objc(CashFlowEntity)public class CashFlowEntity: NSManagedObject, Entity {
    @NSManaged public var name: String?
    @NSManaged public var category: CashFlowCategoryEntity?
}

extension CashFlowEntity: Identifiable {}
