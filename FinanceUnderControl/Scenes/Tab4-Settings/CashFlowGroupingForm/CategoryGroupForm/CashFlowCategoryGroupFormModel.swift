//
//  CashFlowCategoryGroupFormModel.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Foundation
import Shared

struct CashFlowCategoryGroupFormModel: Equatable {
    var name: String?
    var color: CashFlowCategoryColor = .blue
    var includedCategories: [CashFlowCategory] = []
    var otherCategories: [CashFlowCategory] = []

    init(name: String? = nil, color: CashFlowCategoryColor = .blue, type: CashFlowType) {
        self.name = name
        self.color = color
        otherCategories = CashFlowGroupingService.shared.categories(type: type)
    }

    var isValid: Bool {
        guard let name = name else { return false }
        return name.isNotEmpty
    }

    mutating func checkCategory(_ category: CashFlowCategory) {
        if let index = otherCategories.firstIndex(of: category) {
            let category = otherCategories.remove(at: index)
            includedCategories.append(category)
            includedCategories.sort(by: { $0.name < $1.name })
        }
    }

    mutating func uncheckCategory(_ category: CashFlowCategory) {
        if let index = includedCategories.firstIndex(of: category) {
            let category = includedCategories.remove(at: index)
            otherCategories.append(category)
            otherCategories.sort(by: { $0.name < $1.name })
        }
    }

    func model(for formType: CashFlowFormType<CashFlowCategoryGroup>) -> CashFlowCategoryGroup? {
        guard let name = name else { return nil }
        switch formType {
        case let .new(type):
            return CashFlowCategoryGroup(id: UUID().uuidString, name: name, type: type, color: color)
        case let .edit(group):
            return CashFlowCategoryGroup(id: group.id, name: name, type: group.type, color: color)
        }
    }

    func categoriesToBeAdded(to group: CashFlowCategoryGroup) -> [CashFlowCategory] {
        includedCategories
            .filter { $0.group?.id != group.id }
            .map { CashFlowCategory(id: $0.id, name: $0.name, type: $0.type, icon: $0.icon, group: group) }
    }

    func categoriesToBeExcluded(from group: CashFlowCategoryGroup) -> [CashFlowCategory] {
        otherCategories
            .filter { $0.group?.id == group.id }
            .map { CashFlowCategory(id: $0.id, name: $0.name, type: $0.type, icon: $0.icon, group: nil) }
    }

    func categoriesToUpdate(to group: CashFlowCategoryGroup) -> [CashFlowCategory] {
        categoriesToBeAdded(to: group) + categoriesToBeExcluded(from: group)
    }
}

extension CashFlowCategoryGroupFormModel {
    init(from group: CashFlowCategoryGroup) {
        let categories = CashFlowGroupingService.shared.categories(type: group.type)
        name = group.name
        color = group.color
        includedCategories = categories.filter { $0.group?.id == group.id }
        otherCategories = categories.filter { $0.group?.id != group.id }
    }
}
