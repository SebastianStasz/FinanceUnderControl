//
//  CornerRadius.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 27/12/2021.
//

import SwiftUI

public enum CornerRadius: CGFloat {
    case base = 10
}

extension CornerRadius: Identifiable, CaseIterable {

    public var id: CGFloat { rawValue }

    var name: String {
        switch self {
        case .base:
            return "Base"
        }
    }
}
