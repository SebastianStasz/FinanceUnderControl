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
    @Environment(\.editMode) private var editMode

    private let category: CashFlowCategoryEntity
    private let editCategory: () -> Void

    init(for category: CashFlowCategoryEntity,
         editCategory: @autoclosure @escaping () -> Void
    ) {
        self.category = category
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

    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
}

// MARK: - Preview

struct CashFlowCategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowCategoryRow(for: .carExpense, editCategory: {}())
            CashFlowCategoryRow(for: .carExpense, editCategory: {}())
                .environment(\.editMode, .constant(.active))
        }
        .previewLayout(.sizeThatFits)
    }
}
