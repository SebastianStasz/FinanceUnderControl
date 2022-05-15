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
    @Published private var storage = CashFlowGroupingService.shared
    private let categoryService = CashFlowCategoryService()
    @Published private(set) var listSectors: [ListSector<CashFlowCategory>] = []

    init(for type: CashFlowType, coordinator: Coordinator) {
        self.type = type
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        let errorTracker = DriverSubject<Error>()

        CombineLatest(storage.groupsSubscription(type: type), storage.categoriesSubscription(type: type))
            .map { result in
                var sectors: [ListSector<CashFlowCategory>] = []
                let ungroupedCategories = result.1.filter { $0.group.isNil }
                sectors = result.0.map { [weak self] group in
                    ListSector(group.name, elements: result.1.filter { $0.group == group }, editAction: .init(title: .settings_edit_group, action: {
                        self?.binding.navigateTo.send(.presentEditGroupForm(group))
                    }))
                }
                sectors.append(ListSector("Ungrouped", elements: ungroupedCategories, visibleIfEmpty: false))
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
