//
//  CashFlowFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import FinanceCoreData
import Shared
import SwiftUI

extension Currency: Pickerable {
    public var valueName: String {
        code
    }
}

struct CashFlowFormView: BaseView {
    @ObservedObject var viewModel: CashFlowFormVM

    var baseBody: some View {
        FormView {
            Sector(.create_cash_flow_basic_label) {
                LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
                LabeledTextField(.common_amount, viewModel: viewModel.valueInput)
            }

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
    }

    private var primaruButton: HorizontalButtons.Configuration {
        .init(viewModel.formType.confirmButtonTitle, enabled: viewModel.formModel.model.notNil, action: didTapConfirm)
    }

    private func didTapConfirm() {
        viewModel.binding.didTapConfirm.send()
    }

    private var title: String {
        switch viewModel.formType {
        case let .new(type):
            return type == .income ? .cash_flow_add_income : .cash_flow_add_expense
        case let .edit(cashFlow):
            return cashFlow.category.type == .income ? .cash_flow_edit_income : .cash_flow_edit_expense
        }
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
