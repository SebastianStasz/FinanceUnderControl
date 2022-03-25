//
//  TrailingAction.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

public enum TrailingActionType: View {
    case forward(action: Action)
    case radio(isOn: Bool, action: Action)
    case checkbox(isOn: Bool, action: Action)

    public var body: some View {
        switch self {
        case .forward:
            SFSymbol.chevronForward.image
        case let .radio(isOn, action):
            Radio(isOn: isOn, action: action())
        case let .checkbox(isOn, action):
            Checkbox(isOn: isOn, action: action())
        }
    }

    var action: Action {
        switch self {
        case let .forward(action):
            return action
        case let .radio(_, action):
            return action
        case let .checkbox(_, action):
            return action
        }
    }
}

private struct TrailingActionViewModifier: ViewModifier {

    let type: TrailingActionType

    func body(content: Content) -> some View {
        Button(action: type.action) {
            HStack {
                content
                Spacer()
                type
            }
        }
    }
}

public extension View {
    func trailingAction(_ type: TrailingActionType) -> some View {
        modifier(TrailingActionViewModifier(type: type))
    }
}
