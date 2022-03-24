//
//  CashFlowCategoryGroupModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import Foundation
import SSValidation

extension CashFlowCategoryGroupEntity {

    struct Build: CashFlowGroupingBuild {
        typealias Ent = CashFlowCategoryGroupEntity

        var name: String?
        var type: CashFlowType?

        var model: Model? {
            guard let name = name, let type = type else { return nil }
            return CashFlowCategoryGroupEntity.Model(name: name, type: type)
        }
    }
}
