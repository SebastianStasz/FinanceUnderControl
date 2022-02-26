//
//  BaseRowButtonType.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 29/11/2021.
//

import Foundation
import Shared

enum BaseRowButtonType {
    case none
    case forward
    case sheet
    case add

    var systemImage: String? {
        switch self {
        case .none:
            return nil
        case .forward:
            return SFSymbol.chevronForward.name
        case .sheet:
            return SFSymbol.chevronUp.name
        case .add:
            return SFSymbol.plus.name
        }
    }
}
