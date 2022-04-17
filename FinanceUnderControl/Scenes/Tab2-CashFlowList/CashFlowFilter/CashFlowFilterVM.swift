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

final class CashFlowFilterVM: ViewModel {

    final class Action: ViewModel.BaseAction {
        let applyFilters = PassthroughSubject<CashFlowFilter, Never>()
    }

    private(set) var minValueInput = DoubleInputVM(validator: .alwaysValid())
    private(set) var maxValueInput = DoubleInputVM(validator: .alwaysValid())

    @Published var cashFlowFilter = CashFlowFilter()
    @Published var cashFlowCategoriesPredicate: NSPredicate?
    let action = Action()

    override init() {
        super.init()

        minValueInput.assignResult(to: \.cashFlowFilter.minimumValue, on: self)
        maxValueInput.assignResult(to: \.cashFlowFilter.maximumValue, on: self)

        $cashFlowFilter
            .compactMap { filter -> NSPredicate? in
                guard filter.cashFlowSelection != .all,
                      let cashFlowType = filter.cashFlowSelection.type
                else { return nil }
                return CashFlowCategoryEntity.Filter.type(cashFlowType).nsPredicate
            }
            .assign(to: &$cashFlowCategoriesPredicate)

    }

    // MARK: - Interactions

    func applyFilters() {
        action.applyFilters.send(cashFlowFilter)
        baseAction.dismissView.send()
    }

    func resetFilters() {
        cashFlowFilter.resetToDefaultValues()
        applyFilters()
    }

    func onAppear(cashFlowFilter: CashFlowFilter) {
        self.cashFlowFilter = cashFlowFilter
        if let min = cashFlowFilter.minimumValue {
            minValueInput = DoubleInputVM(initialValue: min.asString, validator: .alwaysValid())
        }
    }
}
