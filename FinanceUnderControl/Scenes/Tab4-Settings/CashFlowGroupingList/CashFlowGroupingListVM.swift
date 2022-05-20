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
    let listVM = BaseListVM<CashFlowCategory>()
    private var storage = CashFlowGroupingService.shared
    private let categoryService = CashFlowCategoryService()

    @Published var listVD = BaseListVD<CashFlowCategory>.initialState

    init(for type: CashFlowType, coordinator: Coordinator) {
        self.type = type
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        let errorTracker = DriverSubject<Error>()

        let sectors = CombineLatest(storage.groupsSubscription(type: type), storage.categoriesSubscription(type: type))
            .map { result -> [ListSector<CashFlowCategory>] in
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

        let listOutput = listVM.transform(input: .init(
            sectors: sectors.asDriver,
            isLoading: $isLoading.asDriver)
        )

        listOutput.viewData.assign(to: &$listVD)

        binding.confirmCategoryDeletion
            .withLatestFrom(binding.categoryToDelete)
            .perform(on: self, isLoading: mainLoader, errorTracker: errorTracker) { vm, category in
                try await vm.categoryService.delete(category)
            }
            .sink {}.store(in: &cancellables)

        errorTracker
            .sinkAndStore(on: self) { _, error in
                print(error)
            }
    }
}
