//
//  DesignSystemViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 19/01/2022.
//

import SwiftUI

private struct DesignSystemViewModifier: ViewModifier {

    let title: String

    func body(content: Content) -> some View {
        VStack(spacing: .xxlarge) {
            content
        }
        .padding(.horizontal, .large)
        .padding(.top, .xlarge)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.backgroundPrimary)
        .navigationTitle(title)
    }
}

extension View {
    func designSystemView(_ title: String) -> some View {
        modifier(DesignSystemViewModifier(title: title))
    }
}
