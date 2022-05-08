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

    private let name: String
    private let icon: CashFlowCategoryIcon
    private let color: Color
    private let editCategory: () -> Void

    init(for category: CashFlowCategory,
         editCategory: @autoclosure @escaping () -> Void
    ) {
        name = category.name
        icon = category.icon
        color = .gray
        self.editCategory = editCategory
    }

    var body: some View {
        HStack(spacing: .medium) {
            SquareView(icon: icon.rawValue, color: color, size: 18)
            Text(name)
            Spacer()
            Button(action: {}) {
                SFSymbol.infoCircle.image
                    .frame(width: 18, height: 18)
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

//struct CashFlowCategoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CashFlowCategoryRow(for: .carExpense, editCategory: {}())
//            CashFlowCategoryRow(for: .carExpense, editCategory: {}())
//                .environment(\.editMode, .constant(.active))
//        }
//        .sizeThatFits()
//    }
//}
