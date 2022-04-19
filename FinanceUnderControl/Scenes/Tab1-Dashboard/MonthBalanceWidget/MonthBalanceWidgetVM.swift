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
        
        Publishers.Merge(Just(()), AppVM.shared.events.cashFlowsChanged)
            .startLoading(on: self)
            .asyncMap { _ async -> MonthBalance in
                let incomeValue = await CashFlowEntity.getAll(from: controller, filter: .type(.income), .monthAndYear(from: .now)).map { $0.value }.reduce(0, +)
                let expenseValue = await CashFlowEntity.getAll(from: controller, filter: .type(.expense), .monthAndYear(from: .now)).map { $0.value }.reduce(0, +)
                return MonthBalance(income: .init(incomeValue, currency: .PLN), expense: .init(expenseValue, currency: .PLN))
            }
            .stopLoading(on: self)
            .assign(to: &$monthBalance)
    }
}
