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
    case add

    var systemImage: String? {
        switch self {
        case .none:
            return nil
        case .add:
            return SFSymbol.plus.name
        }
    }
}
