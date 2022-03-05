//
//  CashFlowCategoryColor.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import SwiftUI
import SSUtils

public enum CashFlowCategoryColor: String {
    case red
    case blue
    case yellow
    case green
    case gray
    case pink

    public var color: Color {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .gray:
            return .gray
        case .pink:
            return .pink
        }
    }
}

extension CashFlowCategoryColor: UnknownValueSupport {
    public static var unknownCase: CashFlowCategoryColor {
        return .gray
    }
}
