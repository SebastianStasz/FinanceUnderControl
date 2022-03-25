//
//  Radio.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

public struct Radio: View {

    private let isOn: Bool
    private let action: Action

    public init(isOn: Bool, action: @autoclosure @escaping Action) {
        self.isOn = isOn
        self.action = action
    }

    public var body: some View {
        SelectionView(type: .radio, isOn: isOn, action: action)
    }
}

// MARK: - Preview

struct Radio_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Radio(isOn: true, action: ())
            Radio(isOn: false, action: ())
        }
        .sizeThatFits()
    }
}
