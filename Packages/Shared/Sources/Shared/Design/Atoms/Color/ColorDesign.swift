//
//  ColorDesign.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Foundation

public enum ColorDesign: String {
    case accentGray = "Accent gray"
    case basic = "Basic"

    public enum Background: String, ColorAsset, CaseIterable, Identifiable {
        case background_primary
        case background_secondary

        public var id: String { rawValue }
    }

    public enum AccentGray: String, ColorAsset, CaseIterable, Identifiable {
        case gray_medium

        public var id: String { rawValue }
    }

    public enum Basic: String, ColorAsset, CaseIterable, Identifiable {
        case basic_primary
        case basic_primary_inverted
        case basic_secondary

        public var id: String { rawValue }
    }
}

// MARK: - Helpers

extension ColorDesign: Identifiable, CaseIterable {

    public var id: String { rawValue }

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
