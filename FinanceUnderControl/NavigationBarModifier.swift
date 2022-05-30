//
//  NavigationBarModifier.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 30/05/2022.
//

import Shared
import SwiftUI

private struct NavigationBarModifier<Items: View>: ViewModifier {

    let title: String
    let items: () -> Items

    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(title, style: .navHeadline)
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                items()
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
}

extension View {
    func navigationBar<Content: View>(title: String, content: @escaping () -> Content) -> some View {
        modifier(NavigationBarModifier(title: title, items: content))
    }
}
