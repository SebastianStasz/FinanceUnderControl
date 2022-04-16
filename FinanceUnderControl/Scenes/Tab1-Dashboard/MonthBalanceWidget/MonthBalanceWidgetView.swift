//
//  MonthBalanceWidgetView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/04/2022.
//

import Shared
import SwiftUI
import SSUtils
import Inject

struct MonthBalanceWidgetView: View {
    @ObservedObject private var iO = Inject.observer
    @StateObject private var viewModel = MonthBalanceWidgetVM()

    private var incomeValue: String {
        "+ \(viewModel.monthBalance.incomesValue.asString) \(viewModel.monthBalance.currencyCode)"
    }

    private var expenseValue: String {
        "- \(viewModel.monthBalance.expensesValue.asString) \(viewModel.monthBalance.currencyCode)"
    }

    var body: some View {
        HStack(spacing: .medium) {
            BalanceIndicatorView(incomesValue: viewModel.monthBalance.incomesValue,
                                 expensesValue: viewModel.monthBalance.expensesValue)
            .frame(width: 80, height: 80)
            .padding(4)

            VStack(spacing: .medium) {
                SwiftUI.Text(incomeValue)
                    .foregroundColor(.green)
                    .font(.headline)
                    .fontWeight(.medium)

                SwiftUI.Text(expenseValue)
                    .foregroundColor(.red)
                    .font(.headline)
                    .fontWeight(.medium)
            }
            .infiniteWidth()
        }
        .card()
        .overlay(loadingIndicator)
        .enableInjection()
    }

    @ViewBuilder
    private var loadingIndicator: some View {
        if viewModel.isLoading {
            Color.backgroundSecondary.overlay(ProgressView())
        }
    }
}

// MARK: - Preview

struct MonthBalanceWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MonthBalanceWidgetView()
            MonthBalanceWidgetView().darkScheme()
        }
        .sizeThatFits()
    }
}
