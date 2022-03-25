//
//  CashFlowGroupingFormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/03/2022.
//

import Foundation
import FinanceCoreData

protocol CashFlowGroupingFormModel: Equatable {
    associatedtype Ent: Entity

    var type: CashFlowType? { get set }
    var name: String? { get set }
    var model: Ent.Model? { get }

    init()

    static func newForType(_ type: CashFlowType) -> Self
}

extension CashFlowGroupingFormModel {
    static func newForType(_ type: CashFlowType) -> Self {
        var formModel = Self()
        formModel.type = type
        return formModel
    }
}
