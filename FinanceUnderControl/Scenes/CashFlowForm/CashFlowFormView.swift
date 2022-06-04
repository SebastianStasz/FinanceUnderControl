//
//  CashFlowFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import Shared
import SwiftUI

struct CashFlowFormView: BaseView {

    private enum Field {
        case name, amount
    }

    @ObservedObject var viewModel: CashFlowFormVM
    @FocusState private var focusedField: Field?

    var baseBody: some View {
        FormView {
            Sector(.create_cash_flow_basic_label) {
                BaseTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
                    .focused($focusedField, equals: .name)
                    .onTapGesture { focusedField = .name }
                BaseTextField(.common_amount, viewModel: viewModel.valueInput)
                    .focused($focusedField, equals: .amount)
                    .onTapGesture { focusedField = .amount }
            }
            .onSubmit(didSubmit)

            Sector(.create_cash_flow_more_label) {
                LabeledPicker(.create_cash_flow_currency, elements: Currency.allCases, selection: $viewModel.formModel.currency)
                    .opacity(0.5)
                    .disabled(true)
                LabeledDatePicker(.create_cash_flow_date, selection: $viewModel.formModel.date)
                LabeledPicker(.common_category, elements: viewModel.categories, selection: $viewModel.formModel.category)
            }
        }
        .navigationTitle(title)
        .horizontalButtons(primaryButton: primaruButton)
        .onTapGesture { focusedField = nil }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                focusedField = .name
            }
        }
        .closeButton { viewModel.binding.didTapClose.send() }
        .handleViewModelActions(viewModel)
        .interactiveDismissDisabled(viewModel.wasEdited)
    }

    private var primaruButton: HorizontalButtons.Configuration {
        .init(viewModel.formType.confirmButtonTitle, enabled: viewModel.formModel.isValid, action: didTapConfirm)
    }

    private var title: String {
        switch viewModel.formType {
        case let .new(type):
            return type == .income ? .cash_flow_add_income : .cash_flow_add_expense
        case let .edit(cashFlow):
            return cashFlow.category.type == .income ? .cash_flow_edit_income : .cash_flow_edit_expense
        }
    }

    private func didTapConfirm() {
        viewModel.binding.didTapConfirm.send()
    }

    private func didSubmit() {
        focusedField = focusedField == .name ? .amount : nil
    }
}

// MARK: - Preview

struct CashFlowFormView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CashFlowFormVM(for: .new(.expense), coordinator: PreviewCoordinator())
        CashFlowFormView(viewModel: viewModel)
        CashFlowFormView(viewModel: viewModel).darkScheme()
    }
}
