//
//  WalletFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Shared
import SwiftUI

struct WalletFormView: View {

    @Environment(\.dismiss) private var dismiss
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
        .closeButton(action: dismiss.callAsFunction)
        .horizontalButtons(primaryButton: primaryButton)
        .embedInNavigationView(title: "Edit wallet", displayMode: .inline)
        .onReceive(viewModel.binding.dismiss) { dismiss.callAsFunction() }
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
