//
//  ColorAsset.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 25/07/2022.
//

import SwiftUI

protocol ColorAsset {
    var rawValue: String { get }
    var id: String { get }
}

extension ColorAsset {
    var color: Color {
        Color(self.rawValue, bundle: .module)
    }
}
