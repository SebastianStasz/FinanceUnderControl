//
//  CashFlowFormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/03/2022.
//

import Foundation
import FinanceCoreData

protocol CashFlowFormModel {
    associatedtype Ent: Entity

    var type: CashFlowType? { get set }
    var name: String? { get set }
    var model: Ent.Model? { get }

    init()

    static func newForType(_ type: CashFlowType) -> Self
}

extension CashFlowFormModel {
    static func newForType(_ type: CashFlowType) -> Self {
        var model = Self()
        model.type = type
        return model
    }
}
