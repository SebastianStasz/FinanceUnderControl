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
            Sector(.common_balance) {
                BaseTextField(.common_balance, viewModel: viewModel.balanceInputVM, prompt: balancePrompt)
                LabeledPicker(.create_cash_flow_currency, elements: viewModel.availableCurrencies, selection: $viewModel.formModel.currency)
                    .enabled(!viewModel.formType.isEdit)
            }

            if let date = viewModel.formModel.lastUpdateDate {
                Sector(.common_last_edition_date) {
                    Text(date.string(format: .medium))
                        .card()
                }
            }
        }
        .navigationTitle(viewModel.formType.title)
        .closeButton(action: viewModel.binding.didTapClose.send)
        .horizontalButtons(primaryButton: primaryButton)
        .interactiveDismissDisabled(viewModel.wasEdited)
        .handleViewModelActions(viewModel)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(.common_save, enabled: viewModel.formModel.isValid) { viewModel.binding.didTapConfirm.send() }
    }

    private var balancePrompt: String {
        Decimal(0).formatted(for: PersistentStorage.primaryCurrency)
    }
}

// MARK: - Preview

struct WalletFormView_Previews: PreviewProvider {
    static var previews: some View {
        WalletFormView(viewModel: .init(formType: .new(.PLN)))
        WalletFormView(viewModel: .init(formType: .new(.PLN))).darkScheme()
    }
}
