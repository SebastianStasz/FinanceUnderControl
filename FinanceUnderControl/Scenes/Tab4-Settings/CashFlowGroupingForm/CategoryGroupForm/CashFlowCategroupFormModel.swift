//
//  CashFlowCategroupFormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import Foundation
import Shared

struct CashFlowCategroupFormModel {
    var name: String?
    var color: CashFlowCategoryColor = .blue

    func newModel(forType type: CashFlowType) -> CashFlowCategoryGroup? {
        guard let name = name else { return nil }
        return .init(id: UUID().uuidString, name: name, type: type, color: color)
    }

    func modelAfterEditing(_ group: CashFlowCategoryGroup) -> CashFlowCategoryGroup? {
        guard let name = name else { return nil }
        return .init(id: group.id, name: name, type: group.type, color: color)
    }
}
