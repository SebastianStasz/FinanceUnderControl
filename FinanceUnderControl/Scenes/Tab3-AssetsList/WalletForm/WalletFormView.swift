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
            
        }
    }
}

// MARK: - Preview

struct WalletFormView_Previews: PreviewProvider {
    static var previews: some View {
        let wallet = Wallet(currency: .PLN, balance: 50000)
        WalletFormView(viewModel: .init(wallet: wallet))
        WalletFormView(viewModel: .init(wallet: wallet)).darkScheme()
    }
}
