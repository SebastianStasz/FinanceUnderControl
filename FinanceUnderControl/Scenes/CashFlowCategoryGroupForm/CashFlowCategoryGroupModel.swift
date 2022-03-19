//
//  CashFlowCategoryGroupModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import Foundation
import SSValidation

struct CashFlowCategoryGroupModel: CashFlowFormModel {
    var name: String?
    var type: CashFlowType?

    var data: CashFlowCategoryGroupData? {
        guard let name = name, let type = type else { return nil }
        return CashFlowCategoryGroupData(name: name, type: type)
    }
}
