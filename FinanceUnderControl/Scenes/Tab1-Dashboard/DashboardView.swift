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
            HStack {
                Text("Good afternoon", style: .headlineLarge)
                Spacer()
                Button(systemImage: "gearshape", action: presentSettings)
                    .font(.title3)
                    .buttonStyle(.plain)
                
            }
            .padding(.horizontal, .large)
            Sector("Current month balance") {
                MonthBalanceWidgetView(monthBalance: .init(income: .init(120, currency: .PLN), expense: .init(20, currency: .PLN)))
            }

            if let topExpenses = viewModel.topExpenses {
                HorizontalBarView(viewData: topExpenses)
                    .embedInSection("Top expenses")
            }
        }
        .navigationBarHidden(true)
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
