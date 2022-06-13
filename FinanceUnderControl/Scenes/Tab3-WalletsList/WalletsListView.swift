//
//  WalletsListView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/06/2022.
//

import SwiftUI

struct WalletsListView: View {

    @ObservedObject var viewModel: WalletsListVM

    var body: some View {
        ForEach(viewModel.wallets) {
            Text($0.currency.code)
        }
    }
}

// MARK: - Preview

struct WalletsListView_Previews: PreviewProvider {
    static var previews: some View {
        WalletsListView(viewModel: .init())
        WalletsListView(viewModel: .init()).darkScheme()
    }
}
