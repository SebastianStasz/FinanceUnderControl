//
//  DesignSystemViewModifier.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

private struct DesignSystemViewModifier: ViewModifier {

    let title: String

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .xxlarge) {
            content
        }
        .padding(.horizontal, .large)
        .padding(.top, .large)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.backgroundPrimary)
        .navigationTitle(title)
    }
}

extension View {
    func designSystemView(_ title: String) -> some View {
        modifier(DesignSystemViewModifier(title: title))
    }
}
