//
//  CashFlowCategoryModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import Foundation
import FinanceCoreData
import SSValidation

extension CashFlowCategoryEntity {

    struct FormModel: CashFlowFormModel {
        typealias Ent = CashFlowCategoryEntity

        var name: String?
        var type: CashFlowType?
        var icon: CashFlowCategoryIcon = .houseFill
        var color: CashFlowCategoryColor = .blue

        var model: Model? {
            guard let name = name, let type = type else { return nil }
            return .init(name: name, icon: icon, color: color, type: type)
        }
    }
}
