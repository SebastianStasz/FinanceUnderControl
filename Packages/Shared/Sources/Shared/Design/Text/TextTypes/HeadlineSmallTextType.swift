//
//  HeadlineSmallTextType.swift
//  Shared
//
//  Created by sebastianstaszczyk on 15/04/2022.
//

import SwiftUI

public enum HeadlineSmallTextType {
    case normal
    case action

    var color: Color {
        switch self {
        case .normal:
            return .gray // TODO: Adapt to DS
        case .action:
            return .blue // TODO: Adapt to DS
        }
    }
}
