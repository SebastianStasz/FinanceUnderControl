//
//  CashFlowCategoryModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import Foundation
import FinanceCoreData
import SSValidation

struct CashFlowCategoryModel: CashFlowFormModel {
    var name: String?
    var type: CashFlowType?
    var icon: CashFlowCategoryIcon = .houseFill
    var color: CashFlowCategoryColor = .blue

    var data: CashFlowCategoryData? {
        guard let name = name, let type = type else { return nil }
        return .init(name: name, icon: icon, color: color, type: type)
    }
}
