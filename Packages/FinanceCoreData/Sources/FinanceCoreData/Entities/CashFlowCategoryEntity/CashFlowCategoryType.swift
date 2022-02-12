//
//  CashFlowCategoryType.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import Foundation
import SSUtils
import SwiftUI
import Shared

public enum CashFlowCategoryType: String {
    case income
    case expense
    case unknown
}

public extension CashFlowCategoryType {
    var name: String {
        self.rawValue.capitalized
    }

    var symbol: String {
        switch self {
        case .income:
            return "+"
        default:
            return "-"
        }
    }

    var color: Color {
        switch self {
        case .income:
            return .accentGreen
        default:
            return .accentRed
        }
    }
}

extension CashFlowCategoryType: UnknownValueSupport {
    public static var unknownCase: CashFlowCategoryType {
        .unknown
    }
}
