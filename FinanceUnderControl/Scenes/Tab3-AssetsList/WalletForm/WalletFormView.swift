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
            Sector("Balance") {
                BaseTextField("Balance", viewModel: viewModel.balanceInputVM)
            }
        }
        .closeButton(action: dismiss.callAsFunction)
        .horizontalButtons(primaryButton: primaryButton)
        .embedInNavigationView(title: "Edit wallet", displayMode: .inline)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(.common_save, enabled: viewModel.isFormValid) { viewModel.binding.didTapConfirm.send() }
    }
}

// MARK: - Preview

struct WalletFormView_Previews: PreviewProvider {
    static var previews: some View {
        let wallet = Wallet(currency: .PLN, balanceDate: .now, balance: 50000)
        WalletFormView(viewModel: .init(wallet: wallet))
        WalletFormView(viewModel: .init(wallet: wallet)).darkScheme()
    }
}
