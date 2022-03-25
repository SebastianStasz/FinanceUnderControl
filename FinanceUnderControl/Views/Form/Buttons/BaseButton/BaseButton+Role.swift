//
//  BaseButton+Role.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/02/2022.
//

import SwiftUI

extension BaseButton {

    enum Role {
        case primary
        case secondary

        var background: Color {
            switch self {
            case .primary:
                return .blue
            case .secondary:
                return .gray
            }
        }
    }
}
