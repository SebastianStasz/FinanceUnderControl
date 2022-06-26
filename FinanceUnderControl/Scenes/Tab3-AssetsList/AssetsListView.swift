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
        BaseScroll(viewData: viewModel.listVD) {
            VStack(spacing: .xxlarge) {
                if let totalBalance = viewModel.totalBalance {
                    VStack(alignment: .leading, spacing: .micro) {
                        Text(.common_total_balance, style: .footnote())
                        SwiftUI.Text(totalBalance.asString)
                            .foregroundColor(.white)
                            .font(.title3.weight(.medium))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.xxlarge)
                    .background(Color.accentPrimary)
                }
                SectoredList(viewModel: viewModel.listVM, viewData: viewModel.listVD) { viewData in
                    VStack(spacing: .medium) {
                        HStack(alignment: .top) {
                            Text(viewData.name, style: .currency)
                            Spacer()
                            if let percentageShare = viewData.percentageShare {
                                Text("\(percentageShare.asString)%")
                            }
                        }

                        HStack {
                            Text(viewData.amount, style: .bodyMedium)
                            Spacer()
                            if let amountInPrimaryCurrency = viewData.amountInPrimaryCurrency {
                                Text(amountInPrimaryCurrency, style: .footnote())
                            }
                        }
                    }
                    .card()
                    .editAction(presentAssetEditForm(for: viewData.asset))
                }
            }
        }
        .topPadding(viewModel.totalBalance.notNil ? .medium : 0)
        .navigationBar(title: .tab_assets_title) {
            Button(systemImage: SFSymbol.plus.rawValue, action: presentAddAssetSelection)
        }
    }

    private func presentAssetEditForm(for asset: Asset) {
        viewModel.binding.navigateTo.send(.assetEditForm(asset))
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
