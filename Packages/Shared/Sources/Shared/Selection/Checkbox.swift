//
//  Checkbox.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

public struct Checkbox: View {

    private let isOn: Bool
    private let action: Action

    public init(isOn: Bool, action: @escaping Action) {
        self.isOn = isOn
        self.action = action
    }

    public var body: some View {
        SelectionView(type: .checkbox, isOn: isOn, action: action)
    }
}

// MARK: - Preview

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Checkbox(isOn: true, action: {})
            Checkbox(isOn: false, action: {})
        }
        .sizeThatFits()
    }
}
