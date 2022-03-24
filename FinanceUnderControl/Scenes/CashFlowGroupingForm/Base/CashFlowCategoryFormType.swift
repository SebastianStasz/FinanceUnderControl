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

    var build: Entity.Build {
        switch self {
        case .new(let type):
            return .newForType(type)
        case .edit(let entity):
            return entity.build
        }
    }

    var title: String {
        switch self {
        case .new:
            return .button_create
        case .edit:
            return "Edit"
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
