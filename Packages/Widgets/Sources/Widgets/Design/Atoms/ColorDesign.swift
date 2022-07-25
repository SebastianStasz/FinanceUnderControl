//
//  ColorDesign.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 25/07/2022.
//

import Foundation

public enum ColorDesign: String {
    case background = "Background"

    public enum Background: String, ColorAsset, CaseIterable, Identifiable {
        case background_primary
        case background_secondary

        public var id: String { rawValue }
    }
}
