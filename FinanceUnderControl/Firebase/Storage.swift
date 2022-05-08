//
//  Storage.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation

final class Storage {
    static let shared = Storage()

    private lazy var cashFlowCategoryGroupService = CashFlowCategoryGroupService()
    private lazy var cashFlowCategoryService = CashFlowCategoryService()

    @Published private(set) var cashFlowCategoryGroups: [CashFlowCategoryGroup] = []
    @Published private(set) var cashFlowCategories: [CashFlowCategory] = []

    var incomeCashFlowGroups: [CashFlowCategoryGroup] {
        cashFlowCategoryGroups.filter { $0.type == .income }
    }

    var expenseCashFlowGroups: [CashFlowCategoryGroup] {
        cashFlowCategoryGroups.filter { $0.type == .expense }
    }

    var incomeCashFlowCategories: [CashFlowCategory] {
        cashFlowCategories.filter { $0.type == .income }
    }

    var expenseCashFlowCategories: [CashFlowCategory] {
        cashFlowCategories.filter { $0.type == .expense }
    }

    func updateCashFlowCategoriesIfNeeded() async throws {
        if cashFlowCategories.isEmpty {
            let categories = try await cashFlowCategoryService.getAll()
            DispatchQueue.main.async { [weak self] in
                self?.cashFlowCategories = categories
            }
        }
    }

    func updateCashFlowCategoryGroupsIfNeeded() async throws {
        if cashFlowCategoryGroups.isEmpty {
            let groups = try await cashFlowCategoryGroupService.getAll()
            DispatchQueue.main.async { [weak self] in
                self?.cashFlowCategoryGroups = groups
            }
        }
    }
}
