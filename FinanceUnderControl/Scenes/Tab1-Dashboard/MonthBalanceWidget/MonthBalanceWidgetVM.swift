//
//  MonthBalanceWidgetVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 13/04/2022.
//

import Combine
import FinanceCoreData
import Foundation
import SSUtils

final class MonthBalanceWidgetVM: ViewModel {

    @Published private(set) var monthBalance = MonthBalance.empty

    override init() {
        super.init()

        let controller = AppVM.shared.controller
        let dateFilter = CashFlowEntity.Filter.monthAndYear(from: .now)

        Just(())
            .startLoading(on: self)
            .asyncMap { _ async -> MonthBalance in
                let incomeValue = await CashFlowEntity.getAll(from: controller, filter: [.byType(.income), dateFilter]).map { $0.value }.reduce(0, +)
                let expenseValue = await CashFlowEntity.getAll(from: controller, filter: [.byType(.expense), dateFilter]).map { $0.value }.reduce(0, +)
                return MonthBalance(incomesValue: incomeValue, expensesValue: expenseValue, currencyCode: "PLN")
            }
            .stopLoading(on: self)
            .assign(to: &$monthBalance)
    }
}
