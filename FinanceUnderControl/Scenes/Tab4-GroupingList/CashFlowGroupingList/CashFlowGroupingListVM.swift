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
import SwiftUI

final class CashFlowGroupingListVM: ViewModel {

    struct Binding {
        let navigateTo = DriverSubject<CashFlowGroupingCoordinator.Destination>()
        let categoryToDelete = DriverSubject<CashFlowCategory>()
        let confirmCategoryDeletion = DriverSubject<Void>()
    }

    let binding = Binding()
    let listVM = BaseListVM<CashFlowCategory>()
    private let storage: FirestoreStorageProtocol
    private let categoryService = CashFlowCategoryService()

    @Published var cashFlowType: CashFlowType = .expense
    @Published private(set) var expenseListVD = BaseListVD<CashFlowCategory>.initialState
    @Published private(set) var incomeListVD = BaseListVD<CashFlowCategory>.initialState

    init(storage: FirestoreStorageProtocol = FirestoreStorage.shared, coordinator: CoordinatorProtocol? = nil) {
        self.storage = storage
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        let errorTracker = DriverSubject<Error>()

        let expenseSectors = CombineLatest(storage.groups(ofType: .expense), storage.categories(ofType: .expense))
            .map(with: self) { $0.groupCategories($1.1, by: $1.0) }

        let incomeSectors = CombineLatest(storage.groups(ofType: .income), storage.categories(ofType: .income))
            .map(with: self) { $0.groupCategories($1.1, by: $1.0) }

        let expensesListOutput = listVM.transform(input: .init(
            sectors: expenseSectors.asDriver,
            isLoading: $isLoading.asDriver)
        )

        let incomeslistOutput = listVM.transform(input: .init(
            sectors: incomeSectors.asDriver,
            isLoading: $isLoading.asDriver)
        )

        expensesListOutput.viewData.assign(to: &$expenseListVD)
        incomeslistOutput.viewData.assign(to: &$incomeListVD)

        binding.confirmCategoryDeletion
            .withLatestFrom(binding.categoryToDelete)
            .perform(on: self, isLoading: mainLoader, errorTracker: errorTracker) { vm, category in
                guard try await vm.categoryService.canBeDeleted(category) else {
                    DispatchQueue.main.async {
                        vm.binding.navigateTo.send(.presentCategoryCanNotBeDeleted(category))
                    }
                    return
                }
                try await vm.categoryService.delete(category)
            }
            .sink {}.store(in: &cancellables)

        errorTracker
            .sinkAndStore(on: self) { _, error in
                print(error)
            }
    }

    private func groupCategories(_ categories: [CashFlowCategory], by groups: [CashFlowCategoryGroup]) -> [ListSector<CashFlowCategory>] {
        var sectors: [ListSector<CashFlowCategory>] = []
        let ungroupedCategories = categories.filter { $0.group.isNil }
        sectors = groups.map { [weak self] group in
            ListSector(group.name, elements: categories.filter { $0.group == group }, editAction: .init(title: .settings_edit_group, action: {
                self?.binding.navigateTo.send(.presentEditGroupForm(group))
            }))
        }
        if ungroupedCategories.isNotEmpty {
            sectors.append(ListSector("Ungrouped", elements: ungroupedCategories))
        }
        return sectors
    }
}
