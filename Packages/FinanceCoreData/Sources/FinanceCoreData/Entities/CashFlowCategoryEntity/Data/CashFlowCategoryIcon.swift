//
//  CashFlowCategoryIcon.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import Foundation
import SSUtils

public enum CashFlowCategoryIcon: String {
    case houseFill = "house.fill"
    case gameControllerFill = "gamecontroller.fill"
    case carFill = "car.fill"
    case airplane = "airplane"
    case fuelpumpFill = "fuelpump.fill"
    case personFill = "person.fill"
    case tshirtFill = "tshirt.fill"
    case pawprintFill = "pawprint.fill"
    case leafFill = "leaf.fill"
    case paintbrushFill = "paintbrush.fill"
    case banknoteFill = "banknote.fill"
    case bagFill = "bag.fill"
    case cartFill = "cart.fill"
    case creditcardFill = "creditcard.fill"
    case heartFill = "heart.fill"
    case pillsFill = "pills.fill"
}

extension CashFlowCategoryIcon: UnknownValueSupport {
    public static var unknownCase: CashFlowCategoryIcon {
        return .bagFill
    }
}
