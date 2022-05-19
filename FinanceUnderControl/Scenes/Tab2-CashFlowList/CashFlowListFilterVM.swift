//
//  CashFlowListFilterVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/05/2022.
//

import Combine
import FirebaseFirestore
import Foundation
import SSUtils

final class CashFlowListFilterVM: CombineHelper {

    struct Input {
        let currentCashFlows: Driver<[CashFlow]>
        let fetchMoreCashFlows: Driver<Void>
        let filterResult: Driver<CashFlowFilter>
        let searchText: Driver<String>
    }

    struct Output {
        let filteredCashFlows: Driver<[CashFlow]>
        let isMoreCashFlows: Driver<Bool>
        let isLoading: Driver<Bool>
    }

    var cancellables: Set<AnyCancellable> = []
    private let service = CashFlowService()
    private var lastCashFlow: CashFlow?

    func transform(input: Input) -> Output {
        let loadingIndicator = DriverSubject<Bool>()
        let isMoreCashFlows = DriverSubject<Bool>()
        let filterResultWhenFiltering = input.filterResult.filter { $0.isFiltering }

        let currentCashFlowsFilterResult = filterResultWhenFiltering
            .withLatestFrom(CombineLatest(input.currentCashFlows, input.searchText)) { [weak self] in
                self?.performBaseFiltering(on: $1.0, searchText: $1.1, filterResult: $0)
            }
            .compactMap { $0 }
            .onNext(on: self) { vm, cashFlows in
                vm.lastCashFlow = cashFlows.first
            }

        let moreCashFlowsFilterResult = CombineLatest3(input.searchText, filterResultWhenFiltering, input.fetchMoreCashFlows)
            .perform(on: self, isLoading: loadingIndicator) { vm, result -> [CashFlow] in
                let cashFlowResult = try await vm.service.fetch(filters: result.1.firestoreFilters, startAfter: vm.lastCashFlow)
                DispatchQueue.main.async {
                    isMoreCashFlows.send(cashFlowResult.1.notNil)
                }
                if let lastCashFlow = cashFlowResult.0.last {
                    vm.lastCashFlow = lastCashFlow
                }
                return cashFlowResult.0.filter { $0.name.localizedCaseInsensitiveContainsIfNotEmpty(result.0) }
            }
            .eraseToAnyPublisher().eraseToAnyPublisher()

        let filterResultChanged = input.filterResult

        filterResultChanged
            .withLatestFrom(input.currentCashFlows.map { $0.last })
            .weakAssign(to: \.lastCashFlow, on: self)

        let resetCashFlows = filterResultChanged.map { _ in [CashFlow]() }.asDriver

        let filteredCashFlows = Merge(resetCashFlows, CombineLatest(currentCashFlowsFilterResult, moreCashFlowsFilterResult).map { $0.0 + $0.1 })
            .asDriver

        return Output(filteredCashFlows: filteredCashFlows,
                      isMoreCashFlows: isMoreCashFlows.asDriver,
                      isLoading: loadingIndicator.asDriver)
    }

    private func performBaseFiltering(on cashFlows: [CashFlow], searchText: String, filterResult: CashFlowFilter) -> [CashFlow] {
        let cashFlowType = filterResult.cashFlowSelection.type
        let category = filterResult.cashFlowCategory
        return cashFlows
            .filter { $0.name.localizedCaseInsensitiveContainsIfNotEmpty(searchText) }
            .filter { cashFlowType.isNil ? true : $0.type == cashFlowType }
            .filter { category.isNil ? true : $0.category.id == category?.id }
    }
}

private extension String {
    func localizedCaseInsensitiveContainsIfNotEmpty<T: StringProtocol>(_ searchText: T) -> Bool {
        searchText.isEmpty ? true : self.localizedCaseInsensitiveContains(searchText)
    }
}
