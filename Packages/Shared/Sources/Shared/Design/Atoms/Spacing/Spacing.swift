//
//  Spacing.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 29/11/2021.
//

import SwiftUI

public enum Spacing: CGFloat {
    case micro   = 4
    case small   = 8
    case medium  = 12
    case large   = 16
    case xlarge  = 24
    case xxlarge = 32
    case huge    = 42
}

extension Spacing: Identifiable, CaseIterable {

    public var id: CGFloat { rawValue }

    var name: String {
        switch self {
        case .micro:
            return "Micro"
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .xlarge:
            return "xLarge"
        case .xxlarge:
            return "xxLarge"
        case .huge:
            return "Huge"
        }
    }
}
