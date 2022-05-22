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
        let canFetchMore: Driver<Bool>
        let isLoading: Driver<Bool>
    }

    var cancellables: Set<AnyCancellable> = []
    private lazy var subscription = CashFlowSubscription()

    func transform(input: Input) -> Output {
        let filterResult = input.filterResult.removeDuplicates { prev, new in
            prev.isFiltering ? prev == new : false
        }
        let filterResultWhenFiltering = filterResult.filter { $0.isFiltering }
        let didEndFiltering = filterResult.filter { !$0.isFiltering }

        let fetchMore = input.fetchMore
            .withLatestFrom(input.filterResult)
            .filter { $0.isFiltering }
            .print("Fetch more filtered")
            .asVoid()

        let currentCashFlowsFilterResult = CombineLatest3(filterResultWhenFiltering, input.currentCashFlows, input.searchText)
            .map { Self.performBaseFiltering(on: $0.1, searchText: $0.2, filterResult: $0.0) }
            .print("Current")

        let queryConfiguration = CombineLatest(currentCashFlowsFilterResult, filterResultWhenFiltering)
            .map {
                QueryConfiguration(lastDocument: $0.0.last, filters: $0.1.firestoreFilters)
            }

        let subscription = subscription.transform(input: .init(
            start: filterResultWhenFiltering.asVoid(),
            stop: didEndFiltering.asVoid(),
            fetchMore: fetchMore,
            queryConfiguration: queryConfiguration.asDriver)
        )

        let moreCashFlowsFilterResult = CombineLatest(subscription.cashFlows, input.searchText)
            .map { result in
                result.0.filter { $0.name.localizedCaseInsensitiveContainsIfNotEmpty(result.1) }
            }
            .print("More")

//        let resetCashFlows = input.filterResult.removeDuplicates()
//            .map { filter in
//                [CashFlow]()
//            }
//            .asDriver

        let filteredCashFlows = CombineLatest(currentCashFlowsFilterResult, moreCashFlowsFilterResult).map { $0.0 + $0.1 }
//            .print("Filtered")
            .asDriver

        return Output(filteredCashFlows: filteredCashFlows,
                      canFetchMore: subscription.canFetchMore.prepend(false).print("Can fetch more").asDriver,
                      isLoading: subscription.isLoading)
    }

    private static func performBaseFiltering(on cashFlows: [CashFlow], searchText: String, filterResult: CashFlowFilter) -> [CashFlow] {
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
