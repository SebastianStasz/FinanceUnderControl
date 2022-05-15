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
    @Environment(\.editMode) private var editMode

    @ObservedObject var viewModel: CashFlowGroupingListVM
    @State private var isDeleteConfirmationShown = false

    private var emptyStateVD: EmptyStateVD {
        EmptyStateVD(title: "No elements yet",
                     description: "Groups and categories will appear here after you create it")
    }

    var body: some View {
        BaseList(isLoading: viewModel.isLoading, emptyStateVD: emptyStateVD, sectors: viewModel.listSectors) {
            CashFlowCategoryRow(for: $0, editCategory: presentEditCategoryForm($0))
                .actions(edit: presentEditCategoryForm($0), delete: reportDeleteCategory($0))
                .environment(\.editMode, editMode)
        }
        .confirmationDialog("Delete category", isPresented: $isDeleteConfirmationShown) {
            Button.delete { viewModel.binding.confirmCategoryDeletion.send() }
        }
//        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
    }

    // MARK: - Interactions

    private func reportDeleteCategory(_ category: CashFlowCategory) {
        viewModel.binding.categoryToDelete.send(category)
        isDeleteConfirmationShown = true
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
