//
//  DesignSystem.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

enum DesignSystem: String, CaseIterable {
    case buttons = "Buttons"
    case toggles = "Toggles"
    case pickers = "Pickers"
    case textFields = "Text Fields"
}

extension DesignSystem: View {
    var body: some View {
        Group {
            switch self {
            case .buttons:
                ButtonDSView()
            case .toggles:
                ToggleDSView()
            case .pickers:
                PickerDSView()
            case .textFields:
                TextFieldDSView()
            }
        }
    }
}

extension DesignSystem: Identifiable {
    var title: String { rawValue }
    var id: String { rawValue }
}
