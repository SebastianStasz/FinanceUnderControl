//
//  CashFlowCategoryFormModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import FinanceCoreData
import Foundation

struct CashFlowCategoryFormModel {
    var name: String?
    var icon: CashFlowCategoryIcon = .houseFill
    var color: CashFlowCategoryColor = .default

    func modelAfterEditing(_ category: CashFlowCategory) -> CashFlowCategory? {
        guard let name = name else { return nil }
        return .init(id: category.id, name: name, type: category.type, icon: icon, groupId: category.groupId)
    }
}
