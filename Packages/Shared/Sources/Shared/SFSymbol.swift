//
//  SFSymbol.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import Foundation
import SwiftUI

public enum SFSymbol: String {
    case dashboardTab = "house"
    case cashFlowTab = "doc.text.magnifyingglass"
    case currenciesTab = "dollarsign.circle"
    case settingsTab = "gearshape"
}

public extension SFSymbol {
    var image: Image {
        Image(systemName: rawValue)
    }
}
