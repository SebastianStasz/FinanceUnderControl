//
//  CashFlowListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

import Combine
import Foundation
import SSUtils
import SSValidation

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
    private let filterViewModel = CashFlowListFilterVM()
    private let cashFlowSubscription = CashFlowSubscription()
    let listVM = BaseListVM<CashFlow>()
    let binding = Binding()

    @Published var listVD = BaseListVD<CashFlow>.initialState
    @Published var isFiltering = false
    @Published var searchText = ""

    init(coordinator: CoordinatorProtocol, cashFlowFilterVM: CashFlowFilterVM) {
        self.cashFlowFilterVM = cashFlowFilterVM
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        let searchTextOutput = searchTextVM.transform($searchText.asDriver)
        let filterResult = cashFlowFilterVM.filteringResult().removeDuplicates().asDriver
        let isFiltering = filterResult.map { $0.isFiltering }
        let fetchMore = binding.fetchMoreCashFlows.withLatestFrom(isFiltering).filter { !$0 }

        let subscription = cashFlowSubscription.transform(input: .init(
            start: Just(()).asDriver,
            fetchMore: fetchMore.asVoid(),
            queryConfiguration: Just(.none).asDriver)
        )

        let filterOutput = filterViewModel.transform(input: .init(
            currentCashFlows: subscription.cashFlows,
            filterResult: filterResult,
            searchText: searchTextOutput.searchText,
            fetchMore: binding.fetchMoreCashFlows.asDriver)
        )

        let canFetchMore = CombineLatest(subscription.canFetchMore, filterOutput.canFetchMore)
            .withLatestFrom(isFiltering) { $1 ? $0.1 : $0.0 }

        let isSearching = CombineLatest(isFiltering, searchTextOutput.isSearching).map { $0 || $1 }

        let sectors = CombineLatest3(isFiltering, subscription.cashFlows, filterOutput.filteredCashFlows.prepend([]))
            .map { $0.0 ? $0.2 : $0.1 }
            .map { Self.groupCashFlows($0) }

        let listOutput = listVM.transform(input: .init(
            sectors: sectors.asDriver,
            isMoreItems: canFetchMore.asDriver,
            isSearching: isSearching.asDriver,
            isLoading: $isLoading.asDriver)
        )

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

        CombineLatest3(mainLoader, subscription.isLoading, filterOutput.isLoading)
            .map { $0.0 || $0.1 || $0.2}
            .assign(to: &$isLoading)
    }

    private static func groupCashFlows(_ cashFlows: [CashFlow]) -> [ListSector<CashFlow>] {
        Dictionary(grouping: cashFlows, by: { $0.date.stringMonthAndYear })
            .map { ListSector($0.key, elements: $0.value) }
    }
}
