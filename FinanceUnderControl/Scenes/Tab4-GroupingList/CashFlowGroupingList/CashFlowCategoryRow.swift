//
//  CashFlowCategoryRow.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 18/03/2022.
//

import Shared
import SwiftUI

struct CashFlowCategoryRow: View {
    @Environment(\.editMode) private var editMode

    let name: String
    let icon: CashFlowCategoryIcon
    let color: Color
    let editCategory: () -> Void

    var body: some View {
        HStack(spacing: .medium) {
            SquareView(icon: icon.rawValue, color: color, size: 18)
            Text(name)
            Spacer()
            Button(action: editCategory) {
                SFSymbol.infoCircle.image
                    .frame(width: 18, height: 18)
            }
            .displayIf(isEditing, withTransition: .scale)
        }
        .card()
    }

    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
}

extension CashFlowCategoryRow {
    init(for category: CashFlowCategory, editCategory: @autoclosure @escaping () -> Void) {
        name = category.name
        icon = category.icon
        color = category.group?.color.color ?? CashFlowCategoryColor.default.color
        self.editCategory = editCategory
    }
}

// MARK: - Preview

struct CashFlowCategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowCategoryRow(name: "Groceries", icon: .cartFill, color: .blue, editCategory: {})
            CashFlowCategoryRow(name: "Groceries", icon: .cartFill, color: .blue, editCategory: {}).darkScheme()
                .environment(\.editMode, .constant(.active))
        }
        .sizeThatFits()
    }
}
