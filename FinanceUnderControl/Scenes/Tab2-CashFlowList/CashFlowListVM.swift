//
//  CashFlowListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

import Combine
import FinanceCoreData
import Foundation
import SSValidation

final class CashFlowListVM: ObservableObject {
    typealias Filter = CashFlowEntity.Filter

    private var cancellables: Set<AnyCancellable> = []
    let minValueInput = DoubleInputVM(validator: .alwaysValid())
    let maxValueInput = DoubleInputVM(validator: .alwaysValid())

    @Published private(set ) var cashFlowPredicate: NSPredicate?
    @Published var cashFlowFilter = CashFlowFilter()
    @Published var searchText = ""

    init() {
        let searchPredicate = $searchText
            .map { $0.isEmpty ? nil : Filter.nameContains($0).nsPredicate }

        Publishers.CombineLatest(searchPredicate, $cashFlowFilter)
            .map { [$0, $1.nsPredicate].andNSPredicate }
            .assign(to: &$cashFlowPredicate)


        minValueInput.result().sink { [weak self] in
            self?.cashFlowFilter.minimumValue = $0
        }
        .store(in: &cancellables)

        maxValueInput.result().sink { [weak self] in
            self?.cashFlowFilter.maximumValue = $0
        }
        .store(in: &cancellables)
    }
}
