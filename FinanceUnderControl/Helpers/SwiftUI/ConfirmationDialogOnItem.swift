//
//  ConfirmationDialogOnItem.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 04/04/2022.
//

import Combine
import SwiftUI

private struct ConfirmationDialogOnItem<A: View, T>: ViewModifier {
    @State private var isConfirmationShown = false
    @Binding private var item: T?

    private let title: String
    private let titleVisibility: SwiftUI.Visibility
    private let actions: () -> A

    init(title: String, item: Binding<T?>, titleVisibility: SwiftUI.Visibility, @ViewBuilder actions: @escaping () -> A) {
        self.title = title
        self._item = item
        self.titleVisibility = titleVisibility
        self.actions = actions
    }

    func body(content: Content) -> some View {
        content
            .onReceive(Just(item)) { isConfirmationShown = $0.notNil }
            .confirmationDialog(title, isPresented: $isConfirmationShown, titleVisibility: titleVisibility, actions: actions)
    }
}

extension View {
    func confirmationDialog<A: View, T>(
        _ title: String,
        item: Binding<T?>,
        titleVisibility: SwiftUI.Visibility = .hidden,
        @ViewBuilder actions: @escaping () -> A
    ) -> some View {
        modifier(ConfirmationDialogOnItem(title: title, item: item, titleVisibility: titleVisibility, actions: actions))
    }
}
