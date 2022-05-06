//
//  Storage.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Foundation

final class Storage {
    static let shared = Storage()

    private lazy var cashFlowCategoryService = CashFlowCategoryService()

    @Published private(set) var cashFlowCategories: [CashFlowCategory] = []

    var incomeCashFlowCategories: [CashFlowCategory] {
        cashFlowCategories.filter { $0.type == .income }
    }

    var expenseCashFlowCategories: [CashFlowCategory] {
        cashFlowCategories.filter { $0.type == .expense }
    }

    func updateCashFlowCategories() async throws {
        try await cashFlowCategories = cashFlowCategoryService.getAll()
    }
}
