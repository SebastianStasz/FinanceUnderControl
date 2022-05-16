//
//  CashFlowFormType.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/05/2022.
//

import Foundation
import Shared

enum CashFlowFormType<T: Equatable & CashFlowTypeSupport>: Equatable {
    case new(CashFlowType)
    case edit(T)

    var cashFlowType: CashFlowType {
        switch self {
        case let .new(type):
            return type
        case let .edit(model):
            return model.type
        }
    }

    var isEdit: Bool {
        if case .edit = self { return true }
        return false
    }

    var confirmButtonTitle: String {
        switch self {
        case .new:
            return .button_create
        case .edit:
            return .common_save
        }
    }
}

protocol CashFlowTypeSupport {
    var type: CashFlowType { get }
}
