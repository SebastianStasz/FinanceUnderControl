//
//  DashboardVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 12/04/2022.
//

import FinanceCoreData
import Foundation
import Shared

final class DashboardVM: ViewModel {

    @Published private(set) var topExpenses: HorizontalBarVD?

    func loadData() async {
//        let thisMonthExpenses = await CashFlowEntity.getAll(from: controller, filter: .type(.expense), .monthAndYear(from: .now))
//        let totalExpenses = thisMonthExpenses.reduce(Decimal(0)) { $0 + $1.value }.asDouble
//
//        let expenseBars = Dictionary(grouping: thisMonthExpenses, by: { $0.category })
//            .mapValues { $0.map { $0.value }.reduce(0, +) }
//            .map { HorizontalBarVD.Bar(title: $0.key.name, value: $0.value.asDouble, color: $0.key.color.color) }
//            .sorted(by: { $0.value > $1.value })
//            .prefix(3)
//
//        DispatchQueue.main.async { [weak self] in
//            if expenseBars.isNotEmpty {
//                self?.topExpenses = .init(bars: Array(expenseBars), total: totalExpenses)
//            }
//        }
    }
}
