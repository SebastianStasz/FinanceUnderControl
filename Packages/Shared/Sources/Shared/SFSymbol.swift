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
    case plus = "plus"
    case minus = "minus"
    case forward = "chevron.forward"
    case close = "xmark"
}

public extension SFSymbol {
    var name: String {
        rawValue
    }
    var image: Image {
        Image(systemName: rawValue)
    }
}
