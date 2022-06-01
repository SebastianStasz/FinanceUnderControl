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
        Group {
            //            SegmentedPicker(.cash_flow_filter_type, selection: $viewModel.cashFlowType, elements: CashFlowType.allCases)
            if viewModel.cashFlowType == .expense {
                BaseList(viewModel: viewModel.listVM, viewData: viewModel.expenseListVD, emptyTitle: "No elements yet", emptyDescription: "Groups and categories will appear here after you create it") {
                    CashFlowCategoryRow(for: $0, editCategory: presentEditCategoryForm($0))
                        .actions(edit: presentEditCategoryForm($0), delete: reportDeleteCategory($0))
                        .environment(\.editMode, $editMode)
                }
            }

            if viewModel.cashFlowType == .income {
                BaseList(viewModel: viewModel.listVM, viewData: viewModel.incomeListVD, emptyTitle: "No elements yet", emptyDescription: "Groups and categories will appear here after you create it") {
                    CashFlowCategoryRow(for: $0, editCategory: presentEditCategoryForm($0))
                        .actions(edit: presentEditCategoryForm($0), delete: reportDeleteCategory($0))
                        .environment(\.editMode, $editMode)
                }
            }
        }
        .environment(\.editMode, $editMode)
        .navigationBar(title: .common_categories) {
            Button(editMode.isEditing ? .common_done : .common_edit, action: toggleEditMode)
            Button(systemImage: SFSymbol.plus.rawValue, action: presentFormSelection)
        }
        .confirmationDialog("Delete category", isPresented: $isDeleteConfirmationShown) {
            Button.delete { viewModel.binding.confirmCategoryDeletion.send() }
        }
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