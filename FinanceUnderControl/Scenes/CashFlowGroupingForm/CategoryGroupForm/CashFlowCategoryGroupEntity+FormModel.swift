//
//  CashFlowCategoryGroupEntity+FormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import Foundation
import SSValidation

extension CashFlowCategoryGroupEntity {

    struct FormModel: CashFlowGroupingFormModel {
        typealias Ent = CashFlowCategoryGroupEntity

        var name: String?
        var type: CashFlowType?
        var categories: [CashFlowCategoryEntity] = []

        var model: Model? {
            guard let name = name, let type = type else { return nil }
            return CashFlowCategoryGroupEntity.Model(name: name, type: type, categories: categories)
        }
    }
}
