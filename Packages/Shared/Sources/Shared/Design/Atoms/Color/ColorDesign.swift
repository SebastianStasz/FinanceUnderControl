//
//  ColorDesign.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Foundation

public enum ColorDesign: String {
    case background = "Background"
    case basic = "Basic"
    case gray = "Gray"
    case accent = "Accent"
    case color = "Color"

    public enum Accent: String, ColorAsset, CaseIterable, Identifiable {
        case accent_primary

        public var id: String { rawValue }
    }

    public enum Color: String, ColorAsset, CaseIterable, Identifiable {
        case main_green
        case main_red

        public var id: String { rawValue }
    }

    public enum Background: String, ColorAsset, CaseIterable, Identifiable {
        case background_primary
        case background_secondary

        public var id: String { rawValue }
    }

    public enum Basic: String, ColorAsset, CaseIterable, Identifiable {
        case basic_primary
        case basic_primary_inverted

        public var id: String { rawValue }
    }

    public enum Gray: String, ColorAsset, CaseIterable, Identifiable {
        case gray_main

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
        case .background:
            return Background.allCases
        case .basic:
            return Basic.allCases
        case .gray:
            return Gray.allCases
        case .accent:
            return Accent.allCases
        case .color:
            return Color.allCases
        }
    }

    static var groups: [Self] {
        Self.allCases
    }
}
