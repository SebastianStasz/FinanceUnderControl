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

    @ObservedObject var viewModel: CashFlowCategoryGroupFormVM
//    @State private var isDeleteGroupConfirmationShown = false
//
//    let form: CashFlowFormType<CashFlowCategoryGroupEntity>

    private var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: .micro), count: 6)
    }

    var baseBody: some View {
        FormView {
            Sector(.create_cash_flow_name) {
                LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
            }

            LazyVGrid(columns: grid, alignment: .center, spacing: .micro) {
                ForEach(CashFlowCategoryColor.allCases) { color in
                    CircleView(color: color.color)
                        .selection($viewModel.formModel.color, element: color)
                }
            }
            .embedInSection(.common_color, style: .card)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
//                    Button.delete(titleOnly: true, action: showDeleteConfirmation)
//                        .displayIf(isEditForm)
                }

            }

//            Sector(.common_include) {
//                ForEach(viewModel.formModel.categories) {
//                    CashFlowCategoryGroupItem(for: $0, isOn: true, action: uncheckCategory($0))
//                }
//            }
//            .displayIf(viewModel.formModel.categories.isNotEmpty)
//
//            Sector(.create_cash_flow_more_label) {
//                ForEach(viewModel.otherCategories) {
//                    CashFlowCategoryGroupItem(for: $0, isOn: false, action: checkCategory($0))
//                }
//            }
//            .displayIf(viewModel.otherCategories.isNotEmpty)
        }
//        .confirmationDialog("Delete cash flow group", isPresented: $isDeleteGroupConfirmationShown) {
//            Button.delete(action: deleteCashFlowGroup)
//        }
//        .cashFlowGroupingForm(viewModel: viewModel, form: form)
    }

    private var isEditForm: Bool {
//        guard case .edit = form else { return false }
        return true
    }

    // MARK: - Interactions

//    private func showDeleteConfirmation() {
//        isDeleteGroupConfirmationShown = true
//    }
//
//    private func deleteCashFlowGroup() {
//        viewModel.input.didTapDelete.send(form)
//    }

}

// MARK: - Preview

//struct CashFlowCategoryGroupFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CashFlowCategoryGroupFormView(form: .new(for: .expense))
//            .environment(\.managedObjectContext, PersistenceController.preview.context)
//    }
//}
