//
//  CashFlowCategoryEntity+FormModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import Foundation
import FinanceCoreData
import Shared
import SSValidation

extension CashFlowCategoryEntity {

    struct FormModel: CashFlowGroupingFormModel {
        typealias Ent = CashFlowCategoryEntity

        var name: String?
        var type: CashFlowType?
        var icon: CashFlowCategoryIcon = .houseFill
        var color: CashFlowCategoryColor = .default

        var model: Model? {
            guard let name = name, let type = type else { return nil }
            return .init(name: name, icon: icon, type: type)
        }
    }
}
