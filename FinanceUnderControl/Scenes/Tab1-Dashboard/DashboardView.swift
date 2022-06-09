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
                HorizontalBarView(viewData: .init(bars: Array(topExpenses.bars.prefix(3)), total: topExpenses.total))
                    .embedInSection("Top expenses", editAction: topExpensesEditAction)
            }
        }
        .navigationBar(title: "Good morning") {
            Button(systemImage: SFSymbol.settings.rawValue, action: presentSettings)
        }
    }

    private func presentSettings() {
        viewModel.binding.navigateTo.send(.settings)
    }

    private var topExpensesEditAction: EditAction? {
        guard let topExpenses = viewModel.topExpenses, topExpenses.bars.count > 3 else {
            return nil
        }
        return EditAction(title: "Show all") { viewModel.binding.navigateTo.send(.topExpenses(topExpenses)) }
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
