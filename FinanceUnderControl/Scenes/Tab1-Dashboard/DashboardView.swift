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
        ScrollView {
            VStack(spacing: .xxlarge) {
                MonthBalanceWidgetView(monthBalance: viewModel.monthBalance)
                    .animation(.easeInOut)

                if let balance = viewModel.monthBalance.balance {
                    VStack(alignment: .leading, spacing: .medium) {
                        Text(.common_balance, style: .headlineSmall())
                        SwiftUI.Text(balance.asString)
                            .font(.title3.weight(.medium))
                    }
                    .infiniteWidth(alignment: .leading)
                    .padding(.large)
                    .background(Color.backgroundSecondary)
                    .cornerRadius(.base)
                    .padding(.horizontal, .large)
                }

                if let topExpenses = viewModel.topExpenses {
                    HorizontalBarView(viewData: .init(bars: Array(topExpenses.bars.prefix(3)), total: topExpenses.total, currency: topExpenses.currency))
                        .embedInSection(.dashboard_top_expenses, editAction: topExpensesEditAction)
                        .animation(.easeInOut)
                }

                HStack(alignment: .center) {
                    Picker("Year", selection: $viewModel.monthAndYearPickerVD.year) {
                        ForEach(viewModel.monthAndYearPickerVD.yearRange, id: \.self) { Text($0.asString).tag($0) }
                    }
                    .frame(width: pickerWidth, height: 100)
                    .clipped()
                    .padding(.leading, .large)

                    Picker("Month", selection: $viewModel.monthAndYearPickerVD.month) {
                        ForEach(1...12, id: \.self) { Text(Calendar.current.shortMonthSymbols[$0-1]).tag($0) }
                    }
                    .frame(width: pickerWidth, height: 100)
                    .clipped()
                }
                .zIndex(-1)
                .pickerStyle(.wheel)
                .padding(.top, -4)
            }
            .padding(.top, .medium)
        }
        .background(Color.backgroundPrimary)
        .navigationBar(title: .dashboard_this_month_title) {
            Button(systemImage: SFSymbol.settings.rawValue, action: presentSettings)
            Button(systemImage: SFSymbol.profile.rawValue, action: presentProfile)
        }
    }

    private var pickerWidth: CGFloat {
        UIScreen.screenWidth / 2 - .large
    }

    private func presentSettings() {
        viewModel.binding.navigateTo.send(.settings)
    }

    private func presentProfile() {
        viewModel.binding.navigateTo.send(.profile)
    }

    private var topExpensesEditAction: EditAction? {
        guard let topExpenses = viewModel.topExpenses, topExpenses.bars.count > 3 else {
            return nil
        }
        return EditAction(title: .common_show_all) { viewModel.binding.navigateTo.send(.topExpenses(topExpenses)) }
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
