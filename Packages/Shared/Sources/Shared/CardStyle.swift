//
//  CardStyle.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 05/03/2022.
//

import SwiftUI

public enum CardStyle {
    case primary
    case secondary

    public var color: Color {
        switch self {
        case .primary:
            return .backgroundSecondary
        case .secondary:
            return .backgroundPrimary
        }
    }
}
