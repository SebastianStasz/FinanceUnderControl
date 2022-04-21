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

            if let topExpenses = viewModel.topExpenses {
                HorizontalBarView(viewData: topExpenses)
                    .embedInSection("Top expenses")
            }
        }
        .navigationBarHidden(true)
        .task { await viewModel.loadData() }
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
