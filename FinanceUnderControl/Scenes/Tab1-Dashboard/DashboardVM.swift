//
//  DashboardVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 12/04/2022.
//

import Combine
import Foundation
import Shared
import SSUtils

final class DashboardVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<DashboardCoordinator.Destination>()
    }

    let binding = Binding()

    @Published private(set) var monthBalance: MonthBalance = .empty
    @Published private(set) var topExpenses: HorizontalBarVD?
    @Published var monthAndYearPickerVD = MonthAndYearPickerVD()
    private let cashFlowSubscription = CashFlowSubscription()

    override func viewDidLoad() {
        let configuration = $monthAndYearPickerVD
            .map { QueryConfiguration<CashFlow>(filters: [.isDate(year: $0.year, month: $0.month)]) }

        let subscription = cashFlowSubscription.transform(input: .init(queryConfiguration: configuration.asDriver))
        subscription.canFetchMore.sinkAndStore(on: self, action: { _, _ in })

        let cashFlows = subscription.cashFlows

        cashFlows
            .map { cashFlows -> MonthBalance in
                let income = cashFlows.filter { $0.type == .income }.reduce(0, { $0 + $1.money.value })
                let expense = cashFlows.filter { $0.type == .expense }.reduce(0, { $0 + $1.money.value })
                return MonthBalance(income: .init(income, currency: .PLN), expense: .init(expense, currency: .PLN))
            }
            .assign(to: &$monthBalance)

        cashFlows.map { cashFlows -> HorizontalBarVD in
            let expenses = cashFlows.filter { $0.type == .expense }
            let total = expenses.reduce(0, { $0 + $1.money.value })
            let categories = Dictionary(grouping: expenses, by: { $0.category })
                .mapValues { $0.map { $0.money.value }.reduce(0, +) }
                .map { HorizontalBarVD.Bar(title: $0.key.name, value: $0.value.asDouble, color: $0.key.color) }
                .sorted(by: { $0.value > $1.value })

            return HorizontalBarVD(bars: Array(categories), total: total.asDouble)
        }
        .assign(to: &$topExpenses)
    }
}
