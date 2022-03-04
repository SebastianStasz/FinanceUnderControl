//
//  DesignSystem.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

enum DesignSystem: String, CaseIterable {
    case form

    static var sectors: [String: [Form]] {
        var dic: [String: [Form]] = [:]
        for ds in DesignSystem.allCases {
            dic[ds.rawValue] = ds.elements
        }
        return dic
    }

    var elements: [Form] {
        switch self {
        case .form:
            return Form.allCases
        }
    }

    enum Form: String, Identifiable, CaseIterable, View {
        case buttons = "Buttons"
        case toggles = "Toggles"
        case pickers = "Pickers"
        case textFields = "Text Fields"

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

        var id: String { rawValue }
    }
}

extension DesignSystem: Identifiable {
    var title: String { rawValue }
    var id: String { rawValue }
}
