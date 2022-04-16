//
//  ColorAsset.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 22/10/2021.
//

import SwiftUI

protocol ColorAsset {
    var rawValue: String { get }
    var id: String { get }
}

extension ColorAsset {
    var color: Color { Color(self.rawValue, bundle: .module) }
}
