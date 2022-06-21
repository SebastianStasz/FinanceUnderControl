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
        BaseScroll(viewData: viewModel.walletsListVD) {
            VStack(spacing: .xxlarge) {
                if let totalBalance = viewModel.totalBalance {
                    VStack(alignment: .leading, spacing: .micro) {
                        Text("Total balance", style: .footnote())
                        SwiftUI.Text(totalBalance.asString)
                            .foregroundColor(.white)
                            .font(.title3.weight(.medium))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.xxlarge)
                    .background(Color.accentPrimary)
                }
                SectoredList(viewModel: viewModel.walletsListVM, viewData: viewModel.walletsListVD) { wallet in
                    VStack(spacing: .medium) {
                        Text(wallet.currency.code, style: .bodyMedium)
                        MoneyView(from: wallet.money)
                    }
                    .card()
                    .editAction(presentWalletEditForm(for: wallet))
                }
            }
        }
        .topPadding(.medium)
        .navigationBar(title: .tab_assets_title) {
            Button(systemImage: SFSymbol.plus.rawValue, action: presentAddAssetSelection)
        }
    }

    private func presentWalletEditForm(for wallet: Wallet) {
        viewModel.binding.navigateTo.send(.walletEditForm(wallet))
    }

    private func presentAddAssetSelection() {
        viewModel.binding.navigateTo.send(.addAssetSelection)
    }
}

// MARK: - Preview

struct WalletsListView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsListView(viewModel: .init())
        AssetsListView(viewModel: .init()).darkScheme()
    }
}
