//
//  CashFlowFilterVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

import Combine
import FinanceCoreData
import Foundation
import SSUtils
import SSValidation

final class CashFlowFilterVM: ObservableObject {

    private struct Action {
        let dismissView = PassthroughSubject<Void, Never>()
        let applyFilters = PassthroughSubject<CashFlowFilter, Never>()
    }

    struct Output {
        let dismissView: Driver<Void>
        let cashFlowFilter: Driver<CashFlowFilter>
    }

    @Published var cashFlowFilter = CashFlowFilter()
    @Published var cashFlowCategoriesPredicate: NSPredicate?

    private let action = Action()
    let output: Output

    init() {
        output = .init(dismissView: action.dismissView.asDriver,
                       cashFlowFilter: action.applyFilters.asDriver)

        $cashFlowFilter
            .compactMap { filter -> NSPredicate? in
                guard filter.cashFlowSelection != .all,
                      let cashFlowType = filter.cashFlowSelection.type
                else { return nil }
                return CashFlowCategoryEntity.Filter.typeIs(cashFlowType).nsPredicate
            }
            .assign(to: &$cashFlowCategoriesPredicate)

    }

    // MARK: - Interactions

    func applyFilters() {
        action.applyFilters.send(cashFlowFilter)
        action.dismissView.send()
    }

    func resetFilters() {
        cashFlowFilter.resetToDefaultValues()
        applyFilters()
    }

    func onAppear(cashFlowFilter: CashFlowFilter) {
        self.cashFlowFilter = cashFlowFilter
    }
}
