//
//  ButtonRole.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI

enum ButtonRole {
    case action
    case cancel

    var background: Color {
        switch self {
        case .action:
            return .blue
        case .cancel:
            return .gray
        }
    }
}
