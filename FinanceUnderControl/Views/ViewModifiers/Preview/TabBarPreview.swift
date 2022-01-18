//
//  TabBarPreview.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import SwiftUI

private struct TabBarPreview: ViewModifier {

    func body(content: Content) -> some View {
        TabBarView(view: AnyView(content))
    }
}

extension View {
    func inTabBarPreview() -> some View {
        modifier(TabBarPreview())
    }
}
