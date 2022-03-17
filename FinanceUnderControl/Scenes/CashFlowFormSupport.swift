//
//  CashFlowFormSupport.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Foundation
import FinanceCoreData

protocol CashFlowFormSupport: Entity {
    associatedtype Model: CashFlowFormModel

    var model: Model { get }
}

// MARK: - Compatibility

extension CashFlowCategoryEntity: CashFlowFormSupport {
    var model: CashFlowCategoryModel {
        .init(nameInput: .init(value: name, settings: CashFlowCategoryModel.nameInputSettings), icon: icon, color: color, type: type)
    }
}

extension CashFlowCategoryGroupEntity: CashFlowFormSupport {
    var model: CashFlowCategoryGroupModel {
        .init(nameInput: .init(value: name, settings: CashFlowCategoryGroupModel.nameInputSettings), type: type)
    }
}
