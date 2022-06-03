//
//  CashFlowCategoryGroupFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Shared
import SwiftUI

struct CashFlowCategoryGroupFormView: BaseView {

    @ObservedObject var viewModel: CashFlowCategoryGroupFormVM
    @State private var isDeleteGroupConfirmationPresented = false
    @FocusState private var isFocused: Bool

    var baseBody: some View {
        FormView {
            BaseTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
                .embedInSection(.create_cash_flow_name)
                .focused($isFocused)

            LazyVGrid(columns: grid, alignment: .center, spacing: .micro) {
                ForEach(CashFlowCategoryColor.allCases) { color in
                    CircleView(color: color.color)
                        .selection($viewModel.formModel.color, element: color)
                }
            }
            .embedInSection(.common_color, style: .card)

            Navigation("Categories") { viewModel.binding.navigateTo.send(.manageCategories) }
                .padding(.horizontal, .large)
        }
        .navigationTitle(title)
        .horizontalButtons(primaryButton: primaryButton)
        .confirmationDialog("Czy chcesz usunąć grupę?", isPresented: $isDeleteGroupConfirmationPresented) {
            Button.delete { viewModel.binding.confirmGroupDeletion.send() }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button.delete(titleOnly: true) { isDeleteGroupConfirmationPresented = true }
                    .displayIf(viewModel.formType.isEdit)
            }
        }
        .closeButton { viewModel.binding.navigateTo.send(.dismiss) }
        .onTapGesture { isFocused = false }
        .onAppearFocus($isFocused)
        .handleViewModelActions(viewModel)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(viewModel.formType.confirmButtonTitle, enabled: viewModel.formModel.isValid) {
            viewModel.binding.didTapConfirm.send()
        }
    }

    private var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: .micro), count: 6)
    }

    private var title: String {
        if case .new = viewModel.formType {
            return .settings_create_group
        }
        return .settings_edit_group
    }
}

// MARK: - Preview

struct CashFlowCategoryGroupFormView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CashFlowCategoryGroupFormVM(for: .new(.expense), coordinator: PreviewCoordinator())
        CashFlowCategoryGroupFormView(viewModel: viewModel)
        CashFlowCategoryGroupFormView(viewModel: viewModel).darkScheme()
    }
}
