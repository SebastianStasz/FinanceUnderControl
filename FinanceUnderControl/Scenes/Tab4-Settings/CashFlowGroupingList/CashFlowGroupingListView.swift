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

    @State private var isAlertPresented = false

    private var emptyStateVD: EmptyStateVD {
        EmptyStateVD(title: "No elements yet",
                     description: "Groups and categories will appear here after you create it")
    }

    var body: some View {
        BaseList(viewModel.type.namePlural, isLoading: viewModel.isLoading, emptyStateVD: emptyStateVD, sectors: viewModel.listSectors) {
            CashFlowCategoryRow(for: $0, editCategory: showCategoryForm(.edit))
                .actions(edit: (), delete: reportDeleteCategory($0))
                .environment(\.editMode, editMode)
        }
//        .onDelete(perform: showDeleteConfirmation)
//        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton().displayIf(viewModel.listSectors.isNotEmpty)
            }
            Toolbar.trailing(systemImage: SFSymbol.plus.name) {  }
        }
        .confirmationDialog("Delete category", isPresented: $isDeleteConfirmationShown) {
            Button.delete { viewModel.binding.confirmCategoryDeletion.send() }
            Button.cancel {}
        }
//        .sheet(item: $categoryGroupForm) {
//            CashFlowCategoryGroupFormView(form: $0)
//        }
//        .sheet(item: $categoryForm) {
//            CashFlowCategoryFormView(form: $0)
//        }
//        .confirmationDialog(String.settings_select_action, isPresented: $chooseActionConfirmation) {
//            Button(.settings_create_group, action: showCategoryGroupForm(.new(for: type)))
//            Button(.settings_create_category, action: showCategoryForm(.new(for: type)))
//        }
    }

//    private var sectors: [ListSector<CashFlowCategoryEntity>] {
//        var sectors = categoryGroups.map { group -> ListSector<CashFlowCategoryEntity> in
//            let editAction = EditAction(title: .settings_edit_group) {
//                showCategoryGroupForm(.edit(group))
//            }
//            let categories = group.categories.sorted(by: {
//                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
//            })
//            return ListSector(group.name, elements: categories, editAction: editAction, visibleIfEmpty: true)
//        }
//        if ungroupedCategories.isNotEmpty {
//            sectors.append(ListSector("Ungrouped", elements: ungroupedCategories.map { $0 }))
//        }
//        return sectors
//    }

    // MARK: - Interactions

    func reportDeleteCategory(_ category: CashFlowCategory) {
        viewModel.binding.categoryToDelete.send(category)
        isDeleteConfirmationShown = true
    }
    private func showCategoryForm(_ form: CashFlowForm) {
//        categoryForm = form
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
