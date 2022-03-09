//
//  CashFlowCategoryForm.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/03/2022.
//

import Foundation
import FinanceCoreData

enum CashFlowCategoryForm {
    case new(for: CashFlowType)
    case edit(CashFlowCategoryEntity)

    var model: CashFlowCategoryModel {
        switch self {
        case .new(let cashFlowCategoryType):
            return .newForType(cashFlowCategoryType)
        case .edit(let cashFlowCategoryEntity):
            return cashFlowCategoryEntity.model
        }
    }

    var confirmButtonTitle: String {
        switch self {
        case .new:
            return .button_create
        case .edit:
            return "Save"
        }
    }

    var entity: CashFlowCategoryEntity? {
        guard case let .edit(entity) = self else { return nil }
        return entity
    }
}

extension CashFlowCategoryForm: Identifiable {
    var id: Int {
        switch self {
        case .new: return 0
        case .edit: return 1
        }
    }
}
