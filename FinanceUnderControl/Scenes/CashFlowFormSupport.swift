//
//  CashFlowFormSupport.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Foundation
import FinanceCoreData
import SSValidation

protocol CashFlowFormSupport: Entity {
    associatedtype Model: CashFlowFormModel

    var model: Model { get }
}

// MARK: - Compatibility

extension CashFlowCategoryEntity: CashFlowFormSupport {
    var model: CashFlowCategoryModel {
        .init(name: name, type: type, icon: icon, color: color)
    }
}

extension CashFlowCategoryGroupEntity: CashFlowFormSupport {
    var model: CashFlowCategoryGroupModel {
        .init(name: name, type: type)
    }
}
