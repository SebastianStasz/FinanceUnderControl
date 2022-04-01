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
            .onReceive(viewModel.baseAction.dismissView, perform: dismiss.callAsFunction)
    }
}

extension View {
    func handleViewModelActions(_ viewModel: ViewModel) -> some View {
        modifier(ViewModelActionsModifier(viewModel: viewModel))
    }
}
