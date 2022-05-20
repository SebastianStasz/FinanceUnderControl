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
        let filterResult: Driver<CashFlowFilter>
        let searchText: Driver<String>
        let fetchMore: Driver<Void>
    }

    struct Output {
        let filteredCashFlows: Driver<[CashFlow]>
        let isMoreCashFlows: Driver<Bool>
        let isLoading: Driver<Bool>
    }

    var cancellables: Set<AnyCancellable> = []
    private lazy var subscription = CashFlowSubscription()

    func transform(input: Input) -> Output {
        let isMoreCashFlows = DriverState(false)
        let filterResultWhenFiltering = input.filterResult.filter { $0.isFiltering }.removeDuplicates()
        let fetchMore = input.fetchMore.withLatestFrom(filterResultWhenFiltering).asVoid()

        let currentCashFlowsFilterResult = filterResultWhenFiltering
            .withLatestFrom(CombineLatest(input.currentCashFlows, input.searchText)) { [weak self] in
                self?.performBaseFiltering(on: $1.0, searchText: $1.1, filterResult: $0)
            }
            .compactMap { $0 }

        let queryConfiguration = CombineLatest(currentCashFlowsFilterResult, input.filterResult)
            .map { QueryConfiguration<CashFlow>(lastDocument: $0.0.last, filters: $0.1.firestoreFilters) }

        let subscription = subscription.transform(input: .init(
            start: Just(()).asDriver,
            fetchMore: fetchMore.asDriver,
            queryConfiguration: queryConfiguration.asDriver)
        )

        let moreCashFlowsFilterResult = CombineLatest(subscription.cashFlows, input.searchText)
            .map { result in
                result.0.filter { $0.name.localizedCaseInsensitiveContainsIfNotEmpty(result.1) }
            }

        let filterResultChanged = input.filterResult.removeDuplicates()

        let resetCashFlows = filterResultChanged.map { _ in [CashFlow]() }.asDriver

        let filteredCashFlows = Merge(resetCashFlows, CombineLatest(currentCashFlowsFilterResult, moreCashFlowsFilterResult).map { $0.0 + $0.1 })
            .print("Filtered")
            .asDriver

        return Output(filteredCashFlows: filteredCashFlows,
                      isMoreCashFlows: isMoreCashFlows.asDriver,
                      isLoading: subscription.isLoading)
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
