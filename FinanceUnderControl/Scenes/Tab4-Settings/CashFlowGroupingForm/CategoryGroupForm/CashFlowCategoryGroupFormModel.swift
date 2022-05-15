//
//  CashFlowCategoryGroupFormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Foundation
import Shared

struct CashFlowCategoryGroupFormModel: Equatable {
    var name: String?
    var color: CashFlowCategoryColor = .blue

    var isValid: Bool {
        guard let name = name else { return false }
        return name.isNotEmpty
    }

    func model(for formType: CashFlowFormType<CashFlowCategoryGroup>) -> CashFlowCategoryGroup? {
        guard let name = name else { return nil }
        switch formType {
        case let .new(type):
            return CashFlowCategoryGroup(id: UUID().uuidString, name: name, type: type, color: color)
        case let .edit(group):
            return CashFlowCategoryGroup(id: group.id, name: name, type: group.type, color: color)
        }
    }
}
