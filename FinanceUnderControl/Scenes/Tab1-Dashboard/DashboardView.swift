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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Good morning", style: .navHeadline)
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(systemImage: "gearshape", action: presentSettings)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }

    private func presentSettings() {
        viewModel.binding.navigateTo.send(.settings)
    }
}

// MARK: - Preview

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DashboardVM(coordinator: PreviewCoordinator())
        Group {
            //            DashboardView()
            //            DashboardView().darkScheme()
            DashboardView(viewModel: viewModel)
            DashboardView(viewModel: viewModel).darkScheme()
        }
    }
}
