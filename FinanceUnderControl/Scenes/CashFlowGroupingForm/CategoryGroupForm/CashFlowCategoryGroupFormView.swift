//
//  CashFlowCategoryGroupFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import SwiftUI
import Shared

struct CashFlowCategoryGroupRow: View {

    let category: CashFlowCategoryEntity
    let isChecked: Bool
    let action: Action

    var body: some View {
        HStack {
            Text(category.name)
            Spacer()
            Checkbox(isOn: isChecked, action: action)
        }
        .card()
        .transition(.move(edge: .leading).combined(with: .scale))
    }
}

struct CashFlowCategoryGroupFormView: BaseView {
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = CashFlowCategoryGroupFormVM()
    let form: CashFlowFormType<CashFlowCategoryGroupEntity>

    @State private var includedCategories: [String] = []

    var baseBody: some View {
        FormView {
            Sector("Name") {
                LabeledTextField("Name", viewModel: viewModel.nameInput)
            }

            Sector("Include") {
                ForEach(viewModel.includedCategories) { category in
                    CashFlowCategoryGroupRow(category: category, isChecked: true, action: { uncheckCategory(category) })
                }
            }

            Sector("More") {
                ForEach(viewModel.otherCategories) { category in
                    CashFlowCategoryGroupRow(category: category, isChecked: false, action: { checkCategory(category) })
                }
            }
        }
        .cashFlowGroupingForm(viewModel: viewModel, form: form)
    }

    func uncheckCategory(_ category: CashFlowCategoryEntity) {
        withAnimation(.easeInOut) { viewModel.uncheckCategory(category) }
    }

    func checkCategory(_ category: CashFlowCategoryEntity) {
        withAnimation(.easeInOut) { viewModel.checkCategory(category) }
    }
}

// MARK: - Preview

struct CashFlowCategoryGroupFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryGroupFormView(form: .new(for: .expense))
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
