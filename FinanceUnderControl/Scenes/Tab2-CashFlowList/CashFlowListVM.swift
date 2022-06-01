//
//  CashFlowListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

import Combine
import Foundation
import SSUtils

final class CashFlowListVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<CashFlowListCoordinator.Destination>()
        let cashFlowToDelete = DriverSubject<CashFlow>()
        let confirmCashFlowDeletion = DriverSubject<Void>()
        let fetchMoreCashFlows = DriverSubject<Void>()
    }

    private let service = CashFlowService()
    private let searchTextVM = TextSearchVM()
    private let cashFlowFilterVM: CashFlowFilterVM
    private let cashFlowSubscription = CashFlowSubscription()
    let listVM = BaseListVM<CashFlow>()
    let binding = Binding()
    private var limit = 10

    @Published var listVD = BaseListVD<CashFlow>.initialState
    @Published var isFiltering = false

    init(coordinator: CoordinatorProtocol, cashFlowFilterVM: CashFlowFilterVM) {
        self.cashFlowFilterVM = cashFlowFilterVM
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        let filterResult = cashFlowFilterVM.filteringResult()
            .onNext(on: self) { vm, _ in vm.limit = 10 }

        let fetchMore = binding.fetchMoreCashFlows
            .onNext(on: self) { vm, _ in vm.limit += 20 }

        let queryConfiguration = CombineLatest(filterResult, fetchMore.prepend(()))
            .map(with: self) { QueryConfiguration<CashFlow>(filters: $1.0.firestoreFilters, sorters: [CashFlow.Order.date()], limit: $0.limit) }

        let isFiltering = filterResult.map { $0.isFiltering }.removeDuplicates()
        let subscription = cashFlowSubscription.transform(input: .init(queryConfiguration: queryConfiguration.asDriver))
        let sectors = Merge(filterResult.map { _ in [] }, subscription.cashFlows).map { Self.groupCashFlows($0) }

        let listOutput = listVM.transform(input: .init(
            sectors: sectors.asDriver,
            isMoreItems: subscription.canFetchMore.asDriver,
            isSearching: isFiltering.asDriver,
            isLoading: $isLoading.asDriver)
        )

        isFiltering.assign(to: &$isFiltering)
        listOutput.viewData.assign(to: &$listVD)
        listOutput.fetchMore.sinkAndStore(on: self) { vm, _ in
            vm.binding.fetchMoreCashFlows.send()
        }

        subscription.errors.sinkAndStore(on: self) { _, error in
            print(error)
        }

        binding.confirmCashFlowDeletion
            .withLatestFrom(binding.cashFlowToDelete)
            .perform(on: self, isLoading: mainLoader) { try await $0.service.delete($1) }
            .sink {}.store(in: &cancellables)

        CombineLatest(mainLoader, subscription.isLoading)
            .map { $0.0 || $0.1 }
            .assign(to: &$isLoading)
    }

    private static func groupCashFlows(_ cashFlows: [CashFlow]) -> [ListSector<CashFlow>] {
        Dictionary(grouping: cashFlows, by: { $0.date.monthAndYear })
            .map { ($0.key, $0.value) }
            .sorted(by: { $0.0 > $1.0 })
            .map { ListSector($0.stringMonthAndYear, elements: $1) }
    }
}
