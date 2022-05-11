//
//  CashFlowCategoryFormModel.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 06/03/2022.
//

import FinanceCoreData
import Foundation
import Shared

struct CashFlowCategoryFormModel {
    var name: String?
    var icon: CashFlowCategoryIcon = .houseFill
    var color: CashFlowCategoryColor = .default

    var isValid: Bool {
        guard let name = name else { return false }
        return name.isNotEmpty
    }

    func model(for formType: CashFlowFormType<CashFlowCategory>) -> CashFlowCategory? {
        guard let name = name else { return nil }
        switch formType {
        case let .new(type):
            return CashFlowCategory(id: UUID().uuidString, name: name, type: type, icon: icon, group: nil)
        case let .edit(category):
            return CashFlowCategory(id: category.id, name: name, type: category.type, icon: icon, group: category.group)
        }
    }
}
