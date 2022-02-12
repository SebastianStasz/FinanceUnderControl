//
//  CashFlowListVM.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 08/02/2022.
//

import Combine
import FinanceCoreData
import Foundation

final class CashFlowListVM: ObservableObject {
    typealias Filter = CashFlowEntity.Filter

    @Published private(set )var cashFlowPredicate: NSPredicate?
    @Published var cashFlowFilter = CashFlowFilter()
    @Published var searchText = ""

    init() {
        let searchPredicate = $searchText
            .map { $0.isEmpty ? nil : Filter.nameContains($0).nsPredicate }

        Publishers.CombineLatest(searchPredicate, $cashFlowFilter)
            .map { [$0, $1.nsPredicate].andNSPredicate }
            .assign(to: &$cashFlowPredicate)
    }
}
