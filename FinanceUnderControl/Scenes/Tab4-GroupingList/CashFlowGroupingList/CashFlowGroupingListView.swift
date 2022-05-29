//
//  CashFlowGroupingListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import FinanceCoreData
import Shared
import SSUtils
import SwiftUI

struct CashFlowGroupingListView: View {

    @ObservedObject var viewModel: CashFlowGroupingListVM
    @State private var isDeleteConfirmationShown = false
    @State private var editMode: EditMode = .inactive

    var body: some View {
        VStack {
            VStack(spacing: .large) {
                HStack(spacing: .large) {
                    Text(.common_categories, style: .navHeadline)
                    Spacer()

                    Button(action: toggleEditMode) {
                        SwiftUI.Text(editMode.isEditing ? String.common_done : String.common_edit)
                            .font(.custom(LatoFont.latoRegular.rawValue, size: 19, relativeTo: .title3))
                            .foregroundColor(.primary)
                    }

                    Button(systemImage: "plus", action: presentFormSelection)
                        .font(.custom(LatoFont.latoRegular.rawValue, size: 24, relativeTo: .title3))
                        .foregroundColor(.primary)
                }

                SegmentedPicker(.cash_flow_filter_type, selection: $viewModel.cashFlowType, elements: CashFlowType.allCases)
            }
            .padding(.large)
            .background(Color.backgroundPrimary)

            BaseList(viewModel: viewModel.listVM, viewData: listViewData, emptyTitle: "No elements yet", emptyDescription: "Groups and categories will appear here after you create it") {
                CashFlowCategoryRow(for: $0, editCategory: presentEditCategoryForm($0))
                    .actions(edit: presentEditCategoryForm($0), delete: reportDeleteCategory($0))
                    .environment(\.editMode, $editMode)
            }.animation(.none)
        }
        .navigationBarHidden(true)
        .confirmationDialog("Delete category", isPresented: $isDeleteConfirmationShown) {
            Button.delete { viewModel.binding.confirmCategoryDeletion.send() }
        }
        .environment(\.editMode, $editMode)
//        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
    }

    private var listViewData: BaseListVD<CashFlowCategory> {
        viewModel.cashFlowType == .income ? viewModel.incomeListVD : viewModel.expenseListVD
    }

    // MARK: - Interactions

    private func toggleEditMode() {
        withAnimation(.easeInOut) {
            editMode = editMode.isEditing ? .inactive : .active
        }
    }

    private func reportDeleteCategory(_ category: CashFlowCategory) {
        viewModel.binding.categoryToDelete.send(category)
        isDeleteConfirmationShown = true
    }

    private func presentFormSelection() {
        viewModel.binding.navigateTo.send(.presentFormSelection(viewModel.cashFlowType))
    }

    private func presentEditCategoryForm(_ category: CashFlowCategory) {
        viewModel.binding.navigateTo.send(.presentEditCategoryForm(category))
    }
}

// MARK: - Preview

//struct CashFlowCategoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CashFlowGroupingListView(type: .expense)
//            CashFlowGroupingListView(type: .expense)
//        }
//        .environment(\.managedObjectContext, PersistenceController.preview.context)
//    }
//}
