//
//  ViewModelActionsModifier.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import SwiftUI

private struct ViewModelActionsModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel: ViewModel

    func body(content: Content) -> some View {
        content
            .allowsHitTesting(!viewModel.isLoading)
            .overlay(LoadingIndicator(isLoading: viewModel.isLoading))
    }
}

private struct ViewModelActionsModifier2: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel: ViewModel

    func body(content: Content) -> some View {
        content
            .allowsHitTesting(!viewModel.isLoading)
            .overlay(LoadingIndicator(isLoading: viewModel.isLoading))
    }
}

extension View {
    func handleViewModelActions(_ viewModel: ViewModel) -> some View {
        modifier(ViewModelActionsModifier(viewModel: viewModel))
    }

    func handleViewModelActions2(_ viewModel: ViewModel) -> some View {
        modifier(ViewModelActionsModifier2(viewModel: viewModel))
    }
}
