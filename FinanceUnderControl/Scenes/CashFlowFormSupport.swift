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
        let nameInput = Input<TextInputSettings>(value: name, settings: CashFlowCategoryModel.nameInputSettings)
        return .init(nameInput: nameInput, icon: icon, color: color, type: type)
    }
}

extension CashFlowCategoryGroupEntity: CashFlowFormSupport {
    var model: CashFlowCategoryGroupModel {
        .init(nameInput: .init(value: name, settings: CashFlowCategoryGroupModel.nameInputSettings), type: type)
    }
}
