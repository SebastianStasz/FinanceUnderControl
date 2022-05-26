//
//  DashboardVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 12/04/2022.
//

import Combine
import Foundation
import Shared

final class DashboardVM: ViewModel {

    @Published private(set) var monthBalance: MonthBalance = .empty
    @Published private(set) var topExpenses: HorizontalBarVD?
    private let cashFlowSubscription = CashFlowSubscription()

    override func viewDidLoad() {
        let date = Date()
        let configuration = QueryConfiguration<CashFlow>(filters: [.isDate(year: date.year, month: date.month)])
        let subscription = cashFlowSubscription.transform(input: .init(queryConfiguration: Just(configuration).asDriver))
        subscription.canFetchMore.sinkAndStore(on: self, action: { _, _ in })

        subscription.cashFlows
            .map { cashFlows -> MonthBalance in
                let income = cashFlows.filter { $0.type == .income }.reduce(0, { $0 + $1.money.value })
                let expense = cashFlows.filter { $0.type == .expense }.reduce(0, { $0 + $1.money.value })
                return MonthBalance(income: .init(income, currency: .PLN), expense: .init(expense, currency: .PLN))
            }
            .assign(to: &$monthBalance)
    }
}
