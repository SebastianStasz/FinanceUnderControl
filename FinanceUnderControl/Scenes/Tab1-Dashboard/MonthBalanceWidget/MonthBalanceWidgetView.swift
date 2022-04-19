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

    var body: some View {
        HStack(spacing: .medium) {
            BalanceIndicatorView(incomesValue: viewModel.monthBalance.income.value,
                                 expensesValue: viewModel.monthBalance.expense.value)
            .frame(width: 80, height: 80)
            .padding(4)

            VStack(spacing: .medium) {
                MoneyView(from: viewModel.monthBalance.income, type: .income)
                MoneyView(from: viewModel.monthBalance.expense, type: .expense)
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
                .cornerRadius(.base)
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
