//
//  CashFlowFormSupport.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import CoreData
import FinanceCoreData
import Shared
import SSValidation

protocol CashFlowFormSupport: FirestoreDocument {
//    associatedtype FormModel: CashFlowGroupingFormModel
//
//    var formModel: FormModel { get }

    static func namesInUse(forType type: CashFlowType) -> [String]
    static func create(_ model: Self)
//    @discardableResult func edit(model: Model) -> Bool
}

extension CashFlowFormSupport {
    static func namesInUse(forType type: CashFlowType) -> [String] { [] }
}

// MARK: - Compatibility
