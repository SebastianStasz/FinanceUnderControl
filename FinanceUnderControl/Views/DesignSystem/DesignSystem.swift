//
//  DesignSystem.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

enum DesignSystem: String, CaseIterable {
    case textField = "Text Field"
    case toggle = "Toggle"
    case picker = "Picker"
}

extension DesignSystem: View {
    var body: some View {
        Group {
            switch self {
            case .textField:
                TextFieldDSView()
            case .toggle:
                ToggleDSView()
            case .picker:
                PickerDSView()
            }
        }
    }
}

extension DesignSystem: Identifiable {
    var title: String { rawValue }
    var id: String { rawValue }
}
