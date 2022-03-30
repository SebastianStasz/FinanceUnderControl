//
//  CashFlowCategoryGroupItem.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 25/03/2022.
//

import FinanceCoreData
import SwiftUI

struct CashFlowCategoryGroupItem: View {

    private let category: CashFlowCategoryEntity
    private let isOn: Bool
    private let action: Action

    init(for category: CashFlowCategoryEntity, isOn: Bool, action: @escaping Action) {
        self.category = category
        self.isOn = isOn
        self.action = action
    }

    var body: some View {
        Text(category.name)
            .trailingAction(.checkbox(isOn: isOn, action: action))
            .card()
            .transition(.move(edge: .leading).combined(with: .scale))
    }
}

// MARK: - Preview

struct CashFlowCategoryGroupItem_Previews: PreviewProvider {
    static var previews: some View {
        let category = CashFlowCategoryEntity.createAndReturn(in: PersistenceController.previewEmpty.context, model: .carExpense)
        Group {
            CashFlowCategoryGroupItem(for: category, isOn: true, action: {})
            CashFlowCategoryGroupItem(for: category, isOn: false, action: {})
        }
        .sizeThatFits()
    }
}
