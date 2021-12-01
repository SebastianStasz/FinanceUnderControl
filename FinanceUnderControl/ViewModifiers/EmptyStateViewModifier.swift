//
//  EmptyStateViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import SwiftUI

struct EmptyStateViewModifier: ViewModifier {

    let isEmpty: Bool
    let message: String

    init(isEmpty: Bool, message: String? = nil) {
        self.isEmpty = isEmpty
        self.message = message ?? "No items"
    }

    func body(content: Content) -> some View {
        if isEmpty { Text(message) }
        else { content }
    }
}

extension View {
    func emptyState(isEmpty: Bool, message: String? = nil) -> some View {
        modifier(EmptyStateViewModifier(isEmpty: isEmpty, message: message))
    }
}
