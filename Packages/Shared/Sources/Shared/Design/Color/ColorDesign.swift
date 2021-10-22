//
//  ColorDesign.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import Foundation

enum ColorDesign: String {
    case basic = "Basic"

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
        case .basic:
            return Basic.allCases
        }
    }

    static var groups: [Self] {
        Self.allCases
    }
}
