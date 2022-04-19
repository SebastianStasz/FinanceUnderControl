//
//  DashboardView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import Shared
import SwiftUI

struct DashboardView: View {

    @StateObject private var viewModel = DashboardVM()

    var body: some View {
        FormView {
            Sector("Current month balance") {
                MonthBalanceWidgetView()
            }

            Sector("Top expenses") {
                HorizontalBarView(viewData: viewModel.topExpenses)
                    .overlay(topExpensesLoadingState)
            }
        }
        .navigationBarHidden(true)
        .task { await viewModel.loadData() }
    }

    @ViewBuilder
    private var topExpensesLoadingState: some View {
        if viewModel.topExpenses == .emptyFor(numberOfBars: 3) {
            Color.backgroundSecondary.overlay(ProgressView())
                .cornerRadius(.base)
        }
    }
}

// MARK: - Preview

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView().inTabBarPreview()
            DashboardView().inTabBarPreview().darkScheme()
        }
    }
}
