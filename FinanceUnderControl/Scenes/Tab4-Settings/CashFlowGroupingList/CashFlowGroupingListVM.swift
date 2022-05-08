//
//  CashFlowGroupingListVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 08/05/2022.
//

import Combine
import Foundation
import Shared
import SSUtils

final class CashFlowGroupingListVM: ViewModel {

    let type: CashFlowType
    private let storage = Storage.shared
    @Published private(set) var listSectors: [ListSector<CashFlowCategory>] = []

    init(for type: CashFlowType, coordinator: Coordinator) {
        self.type = type
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        Just(()).performWithLoading(on: self) { [weak self] in
            try await self?.storage.updateCashFlowCategoryGroupsIfNeeded()
            try await self?.storage.updateCashFlowCategoriesIfNeeded()
        }
        .sinkAndStore(on: self) { vm, _ in }

        CombineLatest(storage.$cashFlowCategoryGroups, storage.$cashFlowCategories)
            .map { result in
                var sectors: [ListSector<CashFlowCategory>] = []
                let ungroupedCategories = result.1.filter { $0.groupId.isNil }
                sectors = result.0.map {
                    group in ListSector(group.name, elements: result.1.filter { $0.groupId == group.id })
                }
                if ungroupedCategories.isNotEmpty {
                    sectors.append(ListSector("Ungrouped", elements: ungroupedCategories))
                }
                return sectors
            }
            .assign(to: &$listSectors)
    }
}
