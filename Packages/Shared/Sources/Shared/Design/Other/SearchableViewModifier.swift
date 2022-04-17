//
//  SearchableViewModifier.swift
//  Shared
//
//  Created by sebastianstaszczyk on 17/04/2022.
//

import SwiftUI

private struct SearchableViewModifier: ViewModifier {

    @Binding var text: String
    let isPresented: Bool

    func body(content: Content) -> some View {
        if isPresented {
            content.searchable(text: $text)
        } else {
            content
        }
    }
}

public extension View {
    func searchable(by text: Binding<String>, isPresented: Bool = true) -> some View {
        modifier(SearchableViewModifier(text: text, isPresented: isPresented))
    }
}
