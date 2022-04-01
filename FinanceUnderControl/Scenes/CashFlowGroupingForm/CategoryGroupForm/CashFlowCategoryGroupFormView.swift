//
//  CashFlowCategoryGroupFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import SwiftUI
import Shared

struct CashFlowCategoryGroupFormView: BaseView {
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = CashFlowCategoryGroupFormVM()
    let form: CashFlowFormType<CashFlowCategoryGroupEntity>

    @State private var includedCategories: [String] = []

    var baseBody: some View {
        FormView {
            Sector(.create_cash_flow_name) {
                LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
            }

            Sector(.common_include) {
                ForEach(viewModel.formModel.categories) { category in
                    CashFlowCategoryGroupItem(for: category, isOn: true, action: { uncheckCategory(category) })
                }
            }
            .displayIf(viewModel.formModel.categories.isNotEmpty)

            Sector(.create_cash_flow_more_label) {
                ForEach(viewModel.otherCategories) { category in
                    CashFlowCategoryGroupItem(for: category, isOn: false, action: { checkCategory(category) })
                }
            }
            .displayIf(viewModel.otherCategories.isNotEmpty)
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
