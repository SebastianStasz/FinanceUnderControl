//
//  CashFlowFilterVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

import Combine
import Foundation
import SSUtils
import SSValidation

final class CashFlowFilterVM: ViewModel {

    struct Binding {
        let applyFilters = DriverSubject<Void>()
        let resetFilters = DriverSubject<Void>()
        let dismiss = DriverSubject<Void>()
    }

    @Published var filter = CashFlowFilter()
    @Published private(set) var categories: [CashFlowCategory] = []

    let binding = Binding()
    let minValueInput = DoubleInputVM(validator: .alwaysValid)
    let maxValueInput = DoubleInputVM(validator: .alwaysValid)

    private let storage = CashFlowGroupingService.shared

    override func viewDidLoad() {
        storage.$categories.assign(to: &$categories)
        minValueInput.assignResult(to: \.filter.minimumValue, on: self)
        maxValueInput.assignResult(to: \.filter.maximumValue, on: self)
    }

    func filterResult() -> AnyPublisher<String, Never> {
        let resetFilters = binding.resetFilters
            .handleEvents(on: self) { vm, _ in vm.filter.resetToDefaultValues() }

        return Merge(resetFilters, binding.applyFilters)
            .compactMap { [weak self] _ -> String? in
                self?.binding.dismiss.send()
                return "self?.filter"
            }
            .eraseToAnyPublisher()
    }
}
