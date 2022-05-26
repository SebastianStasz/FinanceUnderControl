//
//  DashboardView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 18/01/2022.
//

import Shared
import SwiftUI

struct DashboardView: View {

    @ObservedObject var viewModel: DashboardVM

    var body: some View {
        FormView {
            Sector("Current month balance") {
                MonthBalanceWidgetView(monthBalance: viewModel.monthBalance)
            }

            if let topExpenses = viewModel.topExpenses {
                HorizontalBarView(viewData: topExpenses)
                    .embedInSection("Top expenses")
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DashboardVM(coordinator: PreviewCoordinator())
        Group {
            DashboardView(viewModel: viewModel)
            DashboardView(viewModel: viewModel).darkScheme()
        }
    }
}
