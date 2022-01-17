//
//  ColorDesign.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Foundation

enum ColorDesign: String {
    case accentGray = "Accent gray"
    case basic = "Basic"

    enum Background: String, ColorAsset, CaseIterable, Identifiable {
        case background_primary
        case background_secondary

        var id: String { rawValue }
    }

    enum AccentGray: String, ColorAsset, CaseIterable, Identifiable {
        case gray_medium

        var id: String { rawValue }
    }

    enum Basic: String, ColorAsset, CaseIterable, Identifiable {
        case basic_primary
        case basic_secondary

        var id: String { rawValue }
    }
}

// MARK: - Helpers

extension ColorDesign: Identifiable, CaseIterable {

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }

    var colors: [ColorAsset] {
        switch self {
        case .accentGray:
            return AccentGray.allCases
        case .basic:
            return Basic.allCases
        }
    }

    static var groups: [Self] {
        Self.allCases
    }
}
