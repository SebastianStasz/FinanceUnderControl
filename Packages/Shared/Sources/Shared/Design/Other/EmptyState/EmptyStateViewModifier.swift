//
//  EmptyStateViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import SwiftUI

private struct EmptyStateViewModifier: ViewModifier {

    private let isEmpty: Bool
    private let viewData: EmptyStateVD

    init(isEmpty: Bool, viewData: EmptyStateVD) {
        self.isEmpty = isEmpty
        self.viewData = viewData
    }

    func body(content: Content) -> some View {
        Color.clear.overlay(
            Group {
                if !isEmpty { content }
                else { EmptyStateView(viewData) }
            }
        )
    }
}

public extension View {
    func emptyState(isEmpty: Bool, viewData: EmptyStateVD) -> some View {
        modifier(EmptyStateViewModifier(isEmpty: isEmpty, viewData: viewData))
    }
}
