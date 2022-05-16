//
//  CashFlowCategoryColor.swift
//  Shared
//
//  Created by sebastianstaszczyk on 13/05/2022.
//

import SwiftUI

public enum CashFlowCategoryColor: String, Codable, CaseIterable, Identifiable {
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

    public var id: String { rawValue }

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

    public static var `default`: CashFlowCategoryColor {
        .gray
    }
}

