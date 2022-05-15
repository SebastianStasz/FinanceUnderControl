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

    var baseBody: some View {
        FormView {
            LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
                .embedInSection(.create_cash_flow_name)

            LazyVGrid(columns: grid, alignment: .center, spacing: .micro) {
                ForEach(CashFlowCategoryColor.allCases) { color in
                    CircleView(color: color.color)
                        .selection($viewModel.formModel.color, element: color)
                }
            }
            .embedInSection(.common_color, style: .card)

            Sector(.common_include) {
                ForEach(viewModel.formModel.includedCategories) {
                    CashFlowCategoryGroupItem(for: $0, isOn: true, action: uncheckCategory($0))
                }
            }
            .displayIf(viewModel.formModel.includedCategories.isNotEmpty)

            Sector(.create_cash_flow_more_label) {
                ForEach(viewModel.formModel.otherCategories) {
                    CashFlowCategoryGroupItem(for: $0, isOn: false, action: checkCategory($0))
                }
            }
            .displayIf(viewModel.formModel.otherCategories.isNotEmpty)
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

    // MARK: - Interactions

    private func uncheckCategory(_ category: CashFlowCategory) {
        viewModel.formModel.uncheckCategory(category)
    }

    private func checkCategory(_ category: CashFlowCategory) {
        viewModel.formModel.checkCategory(category)
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
