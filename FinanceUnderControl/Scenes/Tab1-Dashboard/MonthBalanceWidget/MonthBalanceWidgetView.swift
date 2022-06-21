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
        HStack(spacing: .xxlarge) {
            BalanceIndicatorView(incomesValue: income.value,
                                 expensesValue: expense.value)
            .frame(width: 100, height: 100)
            .shadow(radius: .micro)

            VStack(spacing: .xlarge) {
                HStack(alignment: .bottom, spacing: .medium) {
                    SquareView(icon: "arrow.up", color: .mainGreen, size: 24)
                    VStack(alignment: .leading, spacing: .micro) {
                        Text(.common_income, style: .footnote())
                        SwiftUI.Text(income.asString)
                    }
                }

                HStack(alignment: .bottom, spacing: .medium) {
                    SquareView(icon: "arrow.down", color: .mainRed, size: 24)
                    VStack(alignment: .leading, spacing: .micro) {
                        Text(.common_expenses, style: .footnote())
                        SwiftUI.Text(expense.asString)
                    }
                }
            }
            .foregroundColor(.white)
            .font(.title3.weight(.medium))
            .infiniteWidth()
        }
        .padding(.xxlarge)
        .background(Color.accentPrimary)
        .overlay(loadingIndicator)
    }

    @ViewBuilder
    private var loadingIndicator: some View {
        if monthBalance.isLoading {
            Color.accentPrimary.overlay(ProgressView())
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
