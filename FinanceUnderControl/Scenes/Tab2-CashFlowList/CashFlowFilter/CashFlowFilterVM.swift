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

    let minValueInput = DoubleInputVM(validator: .alwaysValid())
    let maxValueInput = DoubleInputVM(validator: .alwaysValid())

    @Published var cashFlowFilter = CashFlowFilter()
    @Published var cashFlowCategoriesPredicate: NSPredicate?
    let action = Action()

    override init() {
        super.init()

        minValueInput.result().sink { [weak self] in
            self?.cashFlowFilter.minimumValue = $0
        }
        .store(in: &cancellables)

        maxValueInput.result().sink { [weak self] in
            self?.cashFlowFilter.maximumValue = $0
        }
        .store(in: &cancellables)

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
        baseAction.dismissView.send()
    }

    func resetFilters() {
        cashFlowFilter.resetToDefaultValues()
        applyFilters()
    }

    func onAppear(cashFlowFilter: CashFlowFilter) {
        self.cashFlowFilter = cashFlowFilter
    }
}
