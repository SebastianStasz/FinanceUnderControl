//
//  SFSymbol.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import Foundation
import SwiftUI

public enum SFSymbol: String {
    case dashboardTab   = "house"
    case cashFlowTab    = "doc.text.magnifyingglass"
    case currenciesTab  = "dollarsign.circle"
    case settingsTab    = "gearshape"
    case plus           = "plus"
    case minus          = "minus"
    case chevronForward = "chevron.forward"
    case chevronUp      = "chevron.up"
    case close          = "xmark"
    case infoCircle     = "info.circle"
    case filter         = "line.3.horizontal.decrease.circle"
    case checkmarkUnchecked = "square"
    case checkmarkChecked = "checkmark.square.fill"
}

public extension SFSymbol {
    var name: String {
        rawValue
    }
    var image: Image {
        Image(systemName: rawValue)
    }
}
