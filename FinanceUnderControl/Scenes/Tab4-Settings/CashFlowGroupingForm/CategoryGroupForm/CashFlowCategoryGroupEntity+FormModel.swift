//
//  CashFlowCategoryGroupEntity+FormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import Foundation
import Shared
import SSValidation

extension CashFlowCategoryGroupEntity {

    struct FormModel: CashFlowGroupingFormModel {
        typealias Ent = CashFlowCategoryGroupEntity

        var name: String?
        var type: CashFlowType?
        var color: CashFlowCategoryColor = .blue
        var categories: [CashFlowCategoryEntity] = []

        var model: Model? {
            guard let name = name, let type = type else { return nil }
            let categories = categories.sorted(by: {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            })
            return CashFlowCategoryGroupEntity.Model(name: name, type: type, color: color, categories: categories)
        }
    }
}
