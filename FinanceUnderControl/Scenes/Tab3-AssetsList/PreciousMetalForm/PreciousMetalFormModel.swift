//
//  PreciousMetalFormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/06/2022.
//

import Foundation

struct PreciousMetalFormModel: Equatable {
    let lastUpdateDate: Date?
    var amount: Decimal = 0
    var type: PreciousMetalType?

    init(for formType: PreciousMetalFormType) {
        switch formType {
        case .new(let type):
            lastUpdateDate = nil
            self.type = type
        case .edit(let preciousMetal):
            lastUpdateDate = preciousMetal.lastChangeDate
            amount = preciousMetal.ouncesAmount
            type = preciousMetal.type
        }
    }

    var isValid: Bool {
        guard amount >= 0, type.notNil else { return false }
        return true
    }

    func model(for formType: PreciousMetalFormType) -> PreciousMetal? {
        guard let type = type, amount >= 0 else { return nil }
        switch formType {
        case .new:
            return PreciousMetal(type: type, lastChangeDate: .now, ouncesAmount: amount)
        case let .edit(preciousMetal):
            return PreciousMetal(type: preciousMetal.type, lastChangeDate: .now, ouncesAmount: amount)
        }
    }
}
