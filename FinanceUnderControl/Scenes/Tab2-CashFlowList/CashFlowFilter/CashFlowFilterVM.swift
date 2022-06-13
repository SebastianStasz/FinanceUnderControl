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

    private var initialFilter = CashFlowFilter()
    private let storage = Database.shared.grouping

    func filteringResult() -> AnyPublisher<CashFlowFilter, Never> {
        $filter.flatMap { [weak self] filter -> AnyPublisher<[CashFlowCategory], Never> in
            guard let self = self, let type = filter.cashFlowSelection.type else { return Just([]).asDriver }
            return self.storage.categoriesSubscription(type: type)
        }
        .assign(to: &$categories)

        let resetFilters = binding.resetFilters
            .onNext(on: self) { vm, _ in vm.filter.resetToDefaultValues() }

        return Merge3(Just(()), resetFilters, binding.applyFilters)
            .compactMap { [weak self] _ -> CashFlowFilter? in
                guard let self = self else { return nil }
                self.initialFilter = self.filter
                self.binding.dismiss.send()
                return self.filter
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    override func viewDidDisappear() {
        filter = initialFilter
    }
}
