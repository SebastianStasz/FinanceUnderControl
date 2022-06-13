//
//  DesignSystemComponent.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

private struct DesignSystemComponent: ViewModifier {

    let name: String

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .medium) {
            Text(name, style: .footnote())
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

extension View {
    func designSystemComponent(_ name: String) -> some View {
        modifier(DesignSystemComponent(name: name))
    }
}
