//
//  CashFlowFormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/03/2022.
//

import Foundation
import FinanceCoreData

protocol CashFlowFormModel {
    static func newForType(_ type: CashFlowType) -> Self

    var type: CashFlowType? { get set }

    init()
}

extension CashFlowFormModel {
    static func newForType(_ type: CashFlowType) -> Self {
        var model = Self()
        model.type = type
        return model
    }
}
