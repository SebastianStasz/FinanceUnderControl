//
//  PreciousMetalType.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 23/06/2022.
//

import Foundation
import Shared

enum PreciousMetalType: String, Equatable, CaseIterable {
    case XAU
    case XAG

    var code: String {
        rawValue
    }

    var name: String {
        switch self {
        case .XAU:
            return .asset_gold
        case .XAG:
            return .asset_silver
        }
    }
}

extension PreciousMetalType: Pickerable {
    var valueName: String { name }
}
