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

    private var listSectors: BaseListVD<CashFlowCategory> {
        viewModel.cashFlowType == .expense ? viewModel.expenseListVD : viewModel.incomeListVD
    }

    var body: some View {
        ScrollView {
            SectoredList(viewModel: viewModel.listVM, viewData: listSectors) {
                CashFlowCategoryRow(for: $0, editCategory: presentEditCategoryForm($0))
                    .actions(edit: presentEditCategoryForm($0), delete: reportDeleteCategory($0))
                    .environment(\.editMode, $editMode)
            }
        }
        .emptyState(listVD: listSectors, title: "No elements yet", description: "Groups and categories will appear here after you create it")
        .background(Color.backgroundPrimary)
        .environment(\.editMode, $editMode)
        .navigationBar(title: .common_categories) {
            Button(editMode.isEditing ? .common_done : .common_edit, action: toggleEditMode)
            Button(systemImage: SFSymbol.plus.rawValue, action: presentFormSelection)
        }
        .confirmationDialog("Delete category", isPresented: $isDeleteConfirmationShown) {
            Button.delete { viewModel.binding.confirmCategoryDeletion.send() }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                SegmentedPicker(.cash_flow_filter_type, selection: $viewModel.cashFlowType, elements: CashFlowType.allCases)
                    .padding(.bottom, .small)
            }
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
