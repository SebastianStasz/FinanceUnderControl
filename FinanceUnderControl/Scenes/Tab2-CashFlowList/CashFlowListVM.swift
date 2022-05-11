//
//  CashFlowListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

import Combine
import FinanceCoreData
import Foundation
import SSUtils
import SSValidation

final class CashFlowListVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<CashFlowListCoordinator.Destination>()
        let cashFlowToDelete = DriverSubject<CashFlow>()
        let confirmCashFlowDeletion = DriverSubject<Void>()
    }

    private let service: CashFlowService = .init()
    let minValueInput = DoubleInputVM(validator: .alwaysValid)
    let maxValueInput = DoubleInputVM(validator: .alwaysValid)
    let binding = Binding()

    @Published private(set) var listSectors: [ListSector<CashFlow>] = []
    @Published private(set) var filteredListSectors: [ListSector<CashFlow>] = []
    @Published var cashFlowFilter = CashFlowFilter()
    @Published var searchText = ""
//
//        CombineLatest(searchPredicate, $cashFlowFilter)
//            .map { [$0, $1.nsPredicate].andNSPredicate }
//            .assign(to: &$cashFlowPredicate)

    override func viewDidLoad() {
        let cashFlowSubscription = service.subscribe()
        isLoading = true

        minValueInput.assignResult(to: \.cashFlowFilter.minimumValue, on: self)
        maxValueInput.assignResult(to: \.cashFlowFilter.maximumValue, on: self)

        cashFlowSubscription.output
            .sinkAndStore(on: self) { vm, cashFlows in
                vm.listSectors = Self.groupCashFlows(cashFlows)
                vm.isLoading = false
            }

        cashFlowSubscription.error
            .sinkAndStore(on: self) { _, error in
                print(error)
            }

        $searchText.filter { $0.isEmpty }
            .sinkAndStore(on: self) { vm, _ in
                vm.filteredListSectors = []
            }

        $searchText.filter { $0.isNotEmpty }
            .perform(on: self) { [weak self] text in
                try await self?.service.fetch(filters: [.nameContains(text)])
            }
            .sinkAndStore(on: self) { vm, cashFlows in
                vm.filteredListSectors = Self.groupCashFlows(cashFlows!)
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
