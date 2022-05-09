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
}
