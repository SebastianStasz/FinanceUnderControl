//
//  AssetsListView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import Shared
import SwiftUI

struct AssetsListView: View {

    @ObservedObject var viewModel: AssetsListVM

    var body: some View {
        BaseList(viewModel: viewModel.walletsListVM, viewData: viewModel.walletsListVD, emptyTitle: "No wallets", emptyDescription: "") { wallet in
            VStack(spacing: .medium) {
                Text(wallet.currency.code, style: .bodyMedium)
                MoneyView(from: wallet.money)
            }
            .card()
            .editAction(presentForm(for: wallet))
        }
        .navigationBar(title: .tab_assets_title) {}
    }

    private func presentForm(for wallet: Wallet) {
        viewModel.binding.navigateTo.send(.walletForm(wallet))
    }
}

// MARK: - Preview

struct WalletsListView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsListView(viewModel: .init())
        AssetsListView(viewModel: .init()).darkScheme()
    }
}
