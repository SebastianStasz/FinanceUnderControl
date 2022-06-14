//
//  WalletFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Shared
import SwiftUI

struct WalletFormView: View {

    @ObservedObject var viewModel: WalletFormVM

    var body: some View {
        FormView {
            Sector(.create_cash_flow_basic_label) {
                BaseTextField("Balance", viewModel: viewModel.balanceInputVM)
                LabeledPicker(.create_cash_flow_currency, elements: viewModel.availableCurrencies, selection: $viewModel.formModel.currency)
                    .enabled(!viewModel.formType.isEdit)
            }

            if let date = viewModel.formModel.lastUpdateDate {
                Sector("Last update") {
                    Text(date.string(format: .medium))
                }
            }
        }
        .navigationTitle("Edit wallet")
        .closeButton(action: viewModel.binding.didTapClose.send)
        .horizontalButtons(primaryButton: primaryButton)
        .interactiveDismissDisabled(viewModel.wasEdited)
        .handleViewModelActions(viewModel)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(.common_save, enabled: viewModel.formModel.isValid) { viewModel.binding.didTapConfirm.send() }
    }
}

// MARK: - Preview

struct WalletFormView_Previews: PreviewProvider {
    static var previews: some View {
        WalletFormView(viewModel: .init(formType: .new(.PLN)))
        WalletFormView(viewModel: .init(formType: .new(.PLN))).darkScheme()
    }
}
