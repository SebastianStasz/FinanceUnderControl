//
//  Storage.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 05/05/2022.
//

import Combine
import Foundation

final class Storage {
    static let shared = Storage()

    private var cashFlowCategoryGroupService = CashFlowCategoryGroupService()
    private var cashFlowCategoryService = CashFlowCategoryService()

    @Published private(set) var cashFlowCategoryGroups: [CashFlowCategoryGroup] = []
    @Published private(set) var cashFlowCategories: [CashFlowCategory] = []

    private init() {
        cashFlowCategoryGroupService.subscribe().output.assign(to: &$cashFlowCategoryGroups)
        cashFlowCategoryService.subscribe().output.assign(to: &$cashFlowCategories)
    }
}
