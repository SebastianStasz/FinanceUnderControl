//
//  BodyTextType.swift
//  Shared
//
//  Created by sebastianstaszczyk on 15/04/2022.
//

import SwiftUI

public enum BodyTextType {
    case normal
    case action

    var color: Color {
        switch self {
        case .normal:
            return .basicPrimaryInverted
        case .action:
            return .blue // TODO: Adapt to DS
        }
    }
}
