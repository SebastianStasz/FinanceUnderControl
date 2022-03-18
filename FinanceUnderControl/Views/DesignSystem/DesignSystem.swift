//
//  DesignSystem.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

enum DesignSystem: String, CaseIterable {
    case form

    static var sectors: [SectorVD<Form>] {
        DesignSystem.allCases.map {
            SectorVD($0.title, elements: $0.elements)
        }
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
        case sector = "Sector"
        case circleView = "Circle View"

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
                case .sector:
                    SectorDSView()
                case .circleView:
                    CircleViewDSView()
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
