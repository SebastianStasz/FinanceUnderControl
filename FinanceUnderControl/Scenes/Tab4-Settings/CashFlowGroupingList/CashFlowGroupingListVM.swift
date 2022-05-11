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

    struct Binding {
        let navigateTo = DriverSubject<CashFlowGroupingCoordinator.Destination>()
        let categoryToDelete = DriverSubject<CashFlowCategory>()
        let confirmCategoryDeletion = DriverSubject<Void>()
    }

    let type: CashFlowType
    let binding = Binding()
    @Published private var storage = Storage.shared
    private let categoryService = CashFlowCategoryService()
    @Published private(set) var listSectors: [ListSector<CashFlowCategory>] = []

    init(for type: CashFlowType, coordinator: Coordinator) {
        self.type = type
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        let errorTracker = DriverSubject<Error>()

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

        binding.confirmCategoryDeletion
            .withLatestFrom(binding.categoryToDelete)
            .perform(on: self, errorTracker: errorTracker) { [weak self] in
                try await self?.categoryService.delete($0)
            }
            .sink {}
            .store(in: &cancellables)

        errorTracker
            .sinkAndStore(on: self) { _, error in
                print(error)
            }
    }
}
