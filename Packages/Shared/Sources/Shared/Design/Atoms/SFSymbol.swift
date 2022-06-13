//
//  SFSymbol.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 21/10/2021.
//

import SwiftUI

public enum SFSymbol: String {
    case dashboardTab   = "house"
    case cashFlowTab    = "doc.text.magnifyingglass"
    case currenciesTab  = "dollarsign.circle"
    case walletsTab     = "creditcard.circle"
    case cashFlowGroupingTab    = "circle.grid.cross"
    case plus           = "plus"
    case minus          = "minus"
    case chevronForward = "chevron.forward"
    case chevronUp      = "chevron.up"
    case close          = "xmark"
    case infoCircle     = "info.circle"
    case filter         = "slider.horizontal.3"
    case settings       = "gearshape"
    case clear          = "clear"

    case trash = "trash.fill"

    case radioUnchecked = "circle"
    case radioChecked = "circle.inset.filled"

    case checkboxUnchecked = "square"
    case checkboxChecked = "checkmark.square.fill"
}

public extension SFSymbol {
    var name: String {
        rawValue
    }
    var image: Image {
        Image(systemName: rawValue)
    }
}

extension SFSymbol: Identifiable, CaseIterable {
    public var id: String { rawValue }
}
