//
//  FootnoteTextType.swift
//  Shared
//
//  Created by sebastianstaszczyk on 15/04/2022.
//

import SwiftUI

public enum FootnoteTextType {
    case info
    case validation

    var color: Color {
        switch self {
        case .info:
            return .gray // TODO: Adapt to DS
        case .validation:
            return .red.opacity(0.7) // TODO: Adapt to DS
        }
    }
}
