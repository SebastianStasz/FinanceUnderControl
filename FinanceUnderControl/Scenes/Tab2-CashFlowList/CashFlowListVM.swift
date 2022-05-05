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

    private let service: CashFlowService = .init()
    let minValueInput = DoubleInputVM(validator: .alwaysValid)
    let maxValueInput = DoubleInputVM(validator: .alwaysValid)

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
        let errorTracker = DriverSubject<Error>()

        minValueInput.assignResult(to: \.cashFlowFilter.minimumValue, on: self)
        maxValueInput.assignResult(to: \.cashFlowFilter.maximumValue, on: self)

        Just(())
            .performWithLoading(on: self, errorTracker: errorTracker) { [weak self] in
                try await self?.service.fetch()
            }
            .compactMap { $0 }
            .sinkAndStore(on: self) { vm, cashFlows in
                let groupedCashFlows = Dictionary(grouping: cashFlows, by: { $0.date.stringMonthAndYear })
                for group in groupedCashFlows {
                    if let sectorIndex = vm.listSectors.firstIndex(where: { $0.title == group.key }) {
                        vm.listSectors[sectorIndex].elements.append(contentsOf: group.value)
                    } else {
                        vm.listSectors.append(ListSector(group.key, elements: group.value))
                    }
                }
            }
    }
}
