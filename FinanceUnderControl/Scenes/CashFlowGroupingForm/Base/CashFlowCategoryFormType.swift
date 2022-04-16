//
//  CashFlowFormType.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/03/2022.
//

import Foundation
import FinanceCoreData

enum CashFlowFormType<Entity: CashFlowFormSupport> {
    case new(for: CashFlowType)
    case edit(Entity)

    var formModel: Entity.FormModel {
        switch self {
        case .new(let type):
            return .newForType(type)
        case .edit(let entity):
            return entity.formModel
        }
    }

    var title: String {
        switch self {
        case .new(let type):
            if Entity.self == CashFlowEntity.self {
                return type == .income ? .cash_flow_add_income : .cash_flow_add_expense
            } else if Entity.self == CashFlowCategoryGroupEntity.self {
                return .settings_create_group
            } else {
                return .settings_create_category
            }
        case .edit(let entity):
            if Entity.self == CashFlowEntity.self {
                return entity.formModel.type! == .income ? .cash_flow_edit_income : .cash_flow_edit_expense
            } else if Entity.self == CashFlowCategoryGroupEntity.self {
                return .settings_edit_group
            } else {
                return .settings_edit_category
            }
        }
    }

    var confirmButtonTitle: String {
        switch self {
        case .new:
            return .button_create
        case .edit:
            return .common_save
        }
    }

    var entity: Entity? {
        guard case let .edit(entity) = self else { return nil }
        return entity
    }
}

extension CashFlowFormType: Identifiable {
    var id: Int {
        switch self {
        case .new: return 0
        case .edit: return 1
        }
    }
}
