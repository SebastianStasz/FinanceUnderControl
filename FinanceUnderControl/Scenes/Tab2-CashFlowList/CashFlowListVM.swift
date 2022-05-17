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
    }

    private let service = CashFlowService()
    private let cashFlowFilterVM: CashFlowFilterVM
    private(set) var isSearching = false
    let binding = Binding()

    @Published private(set) var cashFlowFilterVD = CashFlowFilter()
    @Published private(set) var listSectors: [ListSector<CashFlow>] = []
    @Published private(set) var filteredListSectors: [ListSector<CashFlow>] = []
    @Published var searchText = ""

    init(coordinator: CoordinatorProtocol, cashFlowFilterVM: CashFlowFilterVM) {
        self.cashFlowFilterVM = cashFlowFilterVM
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        let cashFlowSubscription = service.subscribe()
        isLoading = true

        cashFlowSubscription.output.sinkAndStore(on: self) { vm, cashFlows in
            vm.listSectors = Self.groupCashFlows(cashFlows)
            vm.isLoading = false
        }

        cashFlowSubscription.error.sinkAndStore(on: self) { _, error in
            print(error)
        }

        let searchText = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { $0.count < 3 ? "" : $0 }
            .removeDuplicates()
            .handleEvents(on: self) { vm, text in
                vm.isSearching = text.isNotEmpty
            }

        let textWithoutFilters = CombineLatest(searchText, $cashFlowFilterVD)
            .filter { !$0.1.isFiltering }
            .map { $0.0 }

        textWithoutFilters
            .filter { $0.isEmpty }
            .sinkAndStore(on: self) { vm, _ in
                vm.filteredListSectors = []
            }

        textWithoutFilters
            .filter { $0.isNotEmpty }
            .perform(on: self) { [weak self] text in
                try await self?.service.fetch(filters: [.nameContains(text)])
            }
            .sinkAndStore(on: self) { vm, cashFlows in
                vm.filteredListSectors = Self.groupCashFlows(cashFlows!)
            }

        let cashFlowFilter = cashFlowFilterVM.filteringResult().removeDuplicates()
        cashFlowFilter.assign(to: &$cashFlowFilterVD)

        let filterResult = cashFlowFilter
            .filter { $0.isFiltering }
            .perform(on: self) { [weak self] in
                try await self?.service.fetch(filters: $0.firestoreFilters)
            }
            .compactMap { $0 }

        CombineLatest(filterResult, searchText)
            .map { result in result.1.isEmpty ? result.0 : result.0.filter { $0.name.localizedCaseInsensitiveContains(result.1) } }
            .sinkAndStore(on: self) { vm, cashFlows in
                vm.filteredListSectors = Self.groupCashFlows(cashFlows)
            }

        cashFlowFilter
            .filter { !$0.isFiltering }
            .sinkAndStore(on: self) { vm, _ in
                vm.filteredListSectors = []
            }

        binding.confirmCashFlowDeletion
            .withLatestFrom(binding.cashFlowToDelete)
            .perform(on: self) { [weak self] in
                try await self?.service.delete($0)
            }
            .sink {}.store(in: &cancellables)
    }

    private static func groupCashFlows(_ cashFlows: [CashFlow]) -> [ListSector<CashFlow>] {
        Dictionary(grouping: cashFlows, by: { $0.date.stringMonthAndYear })
            .map { ListSector($0.key, elements: $0.value) }
    }
}
