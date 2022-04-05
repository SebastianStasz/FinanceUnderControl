//
//  CashFlowCategoryGroupFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import Shared
import SwiftUI

struct CashFlowCategoryGroupFormView: BaseView {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = CashFlowCategoryGroupFormVM()

    let form: CashFlowFormType<CashFlowCategoryGroupEntity>

    var baseBody: some View {
        FormView {
            Sector(.create_cash_flow_name) {
                LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
            }

            Sector(.common_include) {
                ForEach(viewModel.formModel.categories) {
                    CashFlowCategoryGroupItem(for: $0, isOn: true, action: uncheckCategory($0))
                }
            }
            .displayIf(viewModel.formModel.categories.isNotEmpty)

            Sector(.create_cash_flow_more_label) {
                ForEach(viewModel.otherCategories) {
                    CashFlowCategoryGroupItem(for: $0, isOn: false, action: checkCategory($0))
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
