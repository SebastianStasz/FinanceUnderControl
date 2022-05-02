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
                LabeledPicker(.common_category, elements: ["1", "2"], selection: $viewModel.formModel.categoryId)
            }
        }
        .asSheet(title: "formType.title", askToDismiss: false, primaryButton: primaruButton)
        .handleViewModelActions(viewModel)
    }

    private var primaruButton: HorizontalButtons.Configuration {
        .init("formType.confirmButtonTitle", enabled: true, action: didTapConfirm)
    }

    private func didTapConfirm() {
        viewModel.binding.didTapConfirm.send()
    }
}

// MARK: - Preview

//struct CashFlowFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CashFlowFormView(for: .new(for: .income))
//        CashFlowFormView(for: .new(for: .income)).darkScheme()
//    }
//}
