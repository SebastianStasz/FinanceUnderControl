//
//  CashFlowListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

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
    let binding = Binding()

    @Published private(set) var isSearching = false
    @Published private(set) var isFiltering = false
    @Published private(set) var listSectors: [ListSector<CashFlow>] = []
    @Published private(set) var filteredListSectors: [ListSector<CashFlow>] = []
    @Published var isMoreCashFlows = true
    @Published var searchText = ""

    init(coordinator: CoordinatorProtocol, cashFlowFilterVM: CashFlowFilterVM) {
        self.cashFlowFilterVM = cashFlowFilterVM
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        mainLoader.send(true)

        let subscription = cashFlowSubscription.transform(input: .init(fetchMore: binding.fetchMoreCashFlows.asDriver))

        let cashFlows = subscription.cashFlows

        subscription.canFetchMore.assign(to: &$isMoreCashFlows)

        subscription.errors.sinkAndStore(on: self) { _, error in
            print(error)
        }

        cashFlows.sinkAndStore(on: self) { vm, cashFlows in
            vm.listSectors = Self.groupCashFlows(cashFlows)
            vm.mainLoader.send(false)
        }

        binding.confirmCashFlowDeletion
            .withLatestFrom(binding.cashFlowToDelete)
            .perform(on: self, isLoading: mainLoader) { try await $0.service.delete($1) }
            .sink {}.store(in: &cancellables)

        let filterResult = cashFlowFilterVM.filteringResult().removeDuplicates().asDriver
        filterResult.map { $0.isFiltering }.assign(to: &$isFiltering)

        let searchTextOutput = searchTextVM.transform($searchText.asDriver)
        searchTextOutput.isSearching.assign(to: &$isSearching)

        let filterInput = CashFlowListFilterVM.Input(
            currentCashFlows: cashFlows,
            fetchMoreCashFlows: binding.fetchMoreCashFlows.asDriver,
            filterResult: filterResult,
            searchText: searchTextOutput.searchText
        )
        let filterOutput = filterViewModel.transform(input: filterInput)

        filterOutput.filteredCashFlows.sinkAndStore(on: self) { vm, cashFlows in
            vm.filteredListSectors = Self.groupCashFlows(cashFlows)
        }

        filterOutput.isMoreCashFlows.assign(to: &$isMoreCashFlows)

        CombineLatest(mainLoader, filterOutput.isLoading)
            .map { $0.0 || $0.1 }
            .assign(to: &$isLoading)
    }

    private static func groupCashFlows(_ cashFlows: [CashFlow]) -> [ListSector<CashFlow>] {
        Dictionary(grouping: cashFlows, by: { $0.date.stringMonthAndYear })
            .map { ListSector($0.key, elements: $0.value) }
    }
}
