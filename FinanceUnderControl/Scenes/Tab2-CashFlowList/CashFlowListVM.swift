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
        let cashFlowToDelete = DriverSubject<CashFlow>()
        let confirmCashFlowDeletion = DriverSubject<Void>()
    }

    private let service: CashFlowService = .init()
    let minValueInput = DoubleInputVM(validator: .alwaysValid)
    let maxValueInput = DoubleInputVM(validator: .alwaysValid)
    let binding = Binding()

    @Published private(set) var cashFlowPredicate: NSPredicate?
    @Published private(set) var listSectors: [ListSector<CashFlow>] = []
    @Published var cashFlowFilter = CashFlowFilter()
    @Published var searchText = ""

//        let searchPredicate = $searchText
//            .map { $0.isEmpty ? nil : Filter.nameContains($0).nsPredicate }
//
//        CombineLatest(searchPredicate, $cashFlowFilter)
//            .map { [$0, $1.nsPredicate].andNSPredicate }
//            .assign(to: &$cashFlowPredicate)

    override func viewDidLoad() {
        let cashFlowSubscription = service.subscribe()

        minValueInput.assignResult(to: \.cashFlowFilter.minimumValue, on: self)
        maxValueInput.assignResult(to: \.cashFlowFilter.maximumValue, on: self)

        cashFlowSubscription.output
            .sinkAndStore(on: self) { vm, cashFlows in
                let groupedCashFlows = Dictionary(grouping: cashFlows, by: { $0.date.stringMonthAndYear })
                vm.listSectors = groupedCashFlows.map { ListSector($0.key, elements: $0.value) }
            }

        cashFlowSubscription.error
            .sinkAndStore(on: self) { _, error in
                print(error)
            }

        binding.confirmCashFlowDeletion
            .withLatestFrom(binding.cashFlowToDelete)
            .performWithLoading(on: self) { [weak self] in
                try await self?.service.delete($0)
            }
            .sink {}.store(in: &cancellables)
    }
}
