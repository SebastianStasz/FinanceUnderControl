//
//  DesignSystemComponent.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

private struct DesignSystemComponent: ViewModifier {

    let name: String

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .small) {
            Text(name)
                .font(.title3)
                .opacity(0.25)
            content
        }
    }
}

extension View {
    func designSystemComponent(_ name: String) -> some View {
        modifier(DesignSystemComponent(name: name))
    }
}
