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

final class CashFlowListFilterVM {

    struct Input {
        let currentCashFlows: Driver<[CashFlow]>
        let filterResult: Driver<CashFlowFilter>
        let searchText: Driver<String>
    }

    struct Output {
        let filteredCashFlows: Driver<[CashFlow]>
        let isLoading: Driver<Bool>
    }

    private let service = CashFlowService()
    private var lastCashFlow: QueryDocumentSnapshot?

    func transform(input: Input) -> Output {
        let loadingIndicator = DriverSubject<Bool>()
        let filterResultWhenFiltering = input.filterResult.filter { $0.isFiltering }

        let currentCashFlowsFilterResult = CombineLatest3(input.currentCashFlows, input.searchText, filterResultWhenFiltering)
            .map(on: self) { $0.performBaseFiltering(on: $1.0, searchText: $1.1, filterResult: $1.2) }

        let filteredCashFlows = CombineLatest3(currentCashFlowsFilterResult, input.searchText, filterResultWhenFiltering)
            .perform(on: self, isLoading: loadingIndicator) { vm, result -> [CashFlow] in
                let cashFlowResult = try await vm.service.fetch(filters: result.2.firestoreFilters, startFrom: vm.lastCashFlow)
                vm.lastCashFlow = cashFlowResult.1
                return cashFlowResult.0.filter { $0.name.localizedCaseInsensitiveContainsIfNotEmpty(result.1) }
            }
            .eraseToAnyPublisher().eraseToAnyPublisher()

        return Output(filteredCashFlows: filteredCashFlows,
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
