//
//  EmptyStateViewModifier.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 01/12/2021.
//

import SwiftUI

private struct EmptyStateViewModifier: ViewModifier {

    private let isEmpty: Bool
    private let isLoading: Bool
    private let viewData: EmptyStateVD

    init(isEmpty: Bool, isLoading: Bool, viewData: EmptyStateVD) {
        self.isEmpty = isEmpty
        self.isLoading = isLoading
        self.viewData = viewData
    }

    func body(content: Content) -> some View {
        Group {
            if !isEmpty { content }
            else { EmptyStateView(viewData, isLoading: isLoading) }
        }
        .overlay(LoadingIndicator(isLoading: isLoading))
    }
}

public extension View {
    func emptyState(isEmpty: Bool, isLoading: Bool, viewData: EmptyStateVD) -> some View {
        modifier(EmptyStateViewModifier(isEmpty: isEmpty, isLoading: isLoading, viewData: viewData))
    }
}
