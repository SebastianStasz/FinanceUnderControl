//
//  CashFlowCategoryColor.swift
//  FinanceCoreData
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import SwiftUI
import SSUtils

public enum CashFlowCategoryColor: String {
    case blue
    case brown
    case cyan
    case gray
    case green
    case indigo
    case mint
    case orange
    case pink
    case red
    case teal
    case yellow

    public var color: Color {
        switch self {
        case .blue:
            return .blue
        case .brown:
            return .brown
        case .cyan:
            return .cyan
        case .gray:
            return .gray
        case .green:
            return .green
        case .indigo:
            return .indigo
        case .mint:
            return .mint
        case .orange:
            return .orange
        case .pink:
            return .pink
        case .red:
            return .red
        case .teal:
            return .teal
        case .yellow:
            return .yellow
        }
    }
}

extension CashFlowCategoryColor: CaseIterable {}

extension CashFlowCategoryColor: Identifiable {
    public var id: String { rawValue }
}

extension CashFlowCategoryColor: UnknownValueSupport {
    public static var unknownCase: CashFlowCategoryColor {
        return .gray
    }
}
