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

    struct Binding {
        let applyFilters = PassthroughSubject<CashFlowFilter, Never>()
    }

    private(set) var minValueInput = DoubleInputVM(validator: .alwaysValid)
    private(set) var maxValueInput = DoubleInputVM(validator: .alwaysValid)

    @Published var filter: CashFlowFilter
    @Published private(set) var categories: [CashFlowCategory] = []
    private let storage = Storage.shared
    let action = Binding()

    init(filter: CashFlowFilter) {
        self.filter = filter
        super.init(coordinator: nil)
    }

    override func viewDidLoad() {
        storage.$cashFlowCategories.assign(to: &$categories)
        minValueInput.assignResult(to: \.filter.minimumValue, on: self)
        maxValueInput.assignResult(to: \.filter.maximumValue, on: self)
    }

    // MARK: - Interactions

    func applyFilters() {
        action.applyFilters.send(filter)
//        baseAction.dismissView.send()
    }

    func resetFilters() {
        filter.resetToDefaultValues()
        applyFilters()
    }

    func onAppear(cashFlowFilter: CashFlowFilter) {
        self.filter = cashFlowFilter
        if let min = cashFlowFilter.minimumValue {
            minValueInput = DoubleInputVM(initialValue: min.asString, validator: .alwaysValid)
        }
    }
}
