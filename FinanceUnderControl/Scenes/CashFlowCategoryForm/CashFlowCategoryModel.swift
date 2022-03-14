//
//  CashFlowCategoryModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import Foundation
import FinanceCoreData
import SSValidation

struct CashFlowCategoryModel {
    var nameInput = Input<TextInputSettings>(settings: nameInputSettings)
    var icon: CashFlowCategoryIcon = .houseFill
    var color: CashFlowCategoryColor = .blue
    var type: CashFlowType = .unknown

    var name: String? {
        nameInput.value
    }

    var data: CashFlowCategoryData? {
        guard let name = name, type != .unknown else { return nil }
        return .init(name: name, icon: icon, color: color, type: type)
    }

    static var nameInputSettings: TextInputSettings {
        .init(maxLength: 30, blocked: .init(message: "Category with this name already exists."))
    }
}

extension CashFlowCategoryModel: CashFlowFormModel {}
