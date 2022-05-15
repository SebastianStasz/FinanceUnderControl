//
//  CashFlowFormType.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 09/05/2022.
//

import Foundation
import Shared

enum CashFlowFormType<T: Equatable>: Equatable {
    case new(CashFlowType)
    case edit(T)

    var isEdit: Bool {
        if case .edit = self { return true  }
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
