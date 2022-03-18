//
//  CashFlowCategoryRow.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import FinanceCoreData
import Shared
import SwiftUI

struct CashFlowCategoryRow: View {

    private let category: CashFlowCategoryEntity
    private let isEditing: Bool
    private let editCategory: () -> Void

    init(for category: CashFlowCategoryEntity,
         isEditing: Bool,
         editCategory: @autoclosure @escaping () -> Void
    ) {
        self.category = category
        self.isEditing = isEditing
        self.editCategory = editCategory
    }

    var body: some View {
        HStack(spacing: .medium) {
            CircleView(color: category.color.color, icon: category.icon, size: 20)
            Text(category.name)
            Spacer()
            Button(action: {}) {
                SFSymbol.infoCircle.image
            }
            .onTapGesture { editCategory() }
            .displayIf(isEditing, withTransition: .scale)
        }
        .card()
    }
}

// MARK: - Preview

struct CashFlowCategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowCategoryRow(for: .carExpense, isEditing: false, editCategory: {}())
            CashFlowCategoryRow(for: .carExpense, isEditing: true, editCategory: {}())
        }
        .previewLayout(.sizeThatFits)
    }
}
