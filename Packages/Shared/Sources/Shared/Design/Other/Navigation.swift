//
//  SwiftUIView.swift
//  Shared
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import SwiftUI

public struct Navigation: View {

    private let title: String
    private let action: () -> Void

    public init(_ title: String, action: @autoclosure @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Text(title).lineLimit(1)
            .trailingAction(.forward(action: action))
            .card()
    }
}

// MARK: - Preview

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Navigation("Title", action: {})
            Navigation("Title", action: {}).darkScheme()
        }
        .sizeThatFits()
    }
}
