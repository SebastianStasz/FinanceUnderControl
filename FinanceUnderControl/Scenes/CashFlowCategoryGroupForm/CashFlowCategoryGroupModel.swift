//
//  CashFlowCategoryGroupModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import Foundation
import SSValidation

struct CashFlowCategoryGroupModel {
    var nameInput = Input<TextInputSettings>(settings: nameInputSettings)
    var type: CashFlowType = .unknown
    
    var name: String? {
        nameInput.value
    }
    
    var data: CashFlowCategoryGroupData? {
        guard let name = name, type != .unknown else { return nil }
        return .init(name: name, type: type)
    }
    
    static var nameInputSettings: TextInputSettings {
        .init(maxLength: 30, blocked: .init(message: "Category with this name already exists."))
    }
}

extension CashFlowCategoryGroupModel: CashFlowFormModel {}
