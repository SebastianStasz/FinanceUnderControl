//
//  MonthBalanceWidgetView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/04/2022.
//

import Shared
import SwiftUI
import SSUtils

struct MonthBalanceWidgetView: View {

    let monthBalance: MonthBalance

    private var income: Money {
        monthBalance.income ?? .init(0, currency: .PLN)
    }

    private var expense: Money {
        monthBalance.expense ?? .init(0, currency: .PLN)
    }

    var body: some View {
        HStack(spacing: .medium) {
            BalanceIndicatorView(incomesValue: income.value,
                                 expensesValue: expense.value)
            .frame(width: 80, height: 80)
            .padding(4)

            VStack(spacing: .medium) {
                MoneyView(from: income, type: .income)
                MoneyView(from: expense, type: .expense)
            }
            .infiniteWidth()
        }
        .card()
        .overlay(loadingIndicator)
    }

    @ViewBuilder
    private var loadingIndicator: some View {
        if monthBalance.isLoading {
            Color.backgroundSecondary.overlay(ProgressView())
                .cornerRadius(.base)
        }
    }
}

// MARK: - Preview

struct MonthBalanceWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MonthBalanceWidgetView(monthBalance: .empty)
            MonthBalanceWidgetView(monthBalance: .empty).darkScheme()
        }
        .sizeThatFits()
    }
}
