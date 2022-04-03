//
//  CashFlowCategoryListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import FinanceCoreData
import Shared
import SSUtils
import SwiftUI

struct CashFlowCategoryListView: View {
    @Environment(\.editMode) private var editMode
    @FetchRequest(sortDescriptors: [], predicate: nil) private var categories: FetchedResults<CashFlowCategoryEntity>
    @FetchRequest private var categoryGroups: FetchedResults<CashFlowCategoryGroupEntity>
    @FetchRequest private var ungroupedCategories: FetchedResults<CashFlowCategoryEntity>

    @State private var isAlertPresented = false
    @State private var isConfirmationDialogPresented = false
    @State private var categoryForm: CashFlowFormType<CashFlowCategoryEntity>?
    @State private var categoryGroupForm: CashFlowFormType<CashFlowCategoryGroupEntity>?
    private let type: CashFlowType

    init(type: CashFlowType) {
        self.type = type
        _categoryGroups = CashFlowCategoryGroupEntity.fetchRequest(forType: type)
        _ungroupedCategories = CashFlowCategoryEntity.fetchRequest(forType: type, group: .ungrouped)
    }

    var body: some View {
        ForEach(categories) { _ in } // Its needed to properly update categories fetched from groups after editing.

        BaseList(type.namePlural, sectors: sectors) { category in
            CashFlowCategoryRow(for: category, editCategory: presentCategoryForm(.edit(category)))
                .environment(\.editMode, editMode)
                .contextMenu {
                    Button.edit(presentCategoryForm(.edit(category)))
                    Button.delete(deleteCategory(category))
                }
        }
        .onDelete(perform: deleteCategory)
        .toolbar { toolbarContent }
        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
        .sheet(item: $categoryGroupForm) { CashFlowCategoryGroupFormView(form: $0) }
        .sheet(item: $categoryForm) { CashFlowCategoryFormView(form: $0) }
        .confirmationDialog(String.settings_select_action, isPresented: $isConfirmationDialogPresented) {
            Button(.settings_create_group, action: presentCategoryGroupForm(.new(for: type)))
            Button(.settings_create_category, action: presentCategoryForm(.new(for: type)))
        }
    }

    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            Toolbar.trailing(systemImage: SFSymbol.plus.name) { presentConfirmationDialog() }
        }
    }

    private var sectors: [ListSector<CashFlowCategoryEntity>] {
        var sectors = categoryGroups.map { group -> ListSector<CashFlowCategoryEntity> in
            let editAction = EditAction(title: .settings_edit_group) {
                presentCategoryGroupForm(.edit(group))
            }
            return ListSector(group.name, elements: group.categories, editAction: editAction, visibleIfEmpty: true)
        }
        sectors.append(ListSector("Ungrouped", elements: ungroupedCategories.map { $0 }))
        return sectors
    }

    // MARK: - Interactions

   private func presentConfirmationDialog() {
       isConfirmationDialogPresented = true
   }

    private func presentCategoryForm(_ form: CashFlowFormType<CashFlowCategoryEntity>) {
        categoryForm = form
    }

    private func deleteCategory(_ category: CashFlowCategoryEntity) {
        let wasDeleted = category.delete()
        if !wasDeleted { isAlertPresented = true }
    }

    private func presentCategoryEditForm(for groupName: String) {
        guard let group = categoryGroups.first(where: { $0.name == groupName }) else { return }
        presentCategoryGroupForm(.edit(group))
    }

    private func presentCategoryGroupForm(_ form: CashFlowFormType<CashFlowCategoryGroupEntity>) {
        categoryGroupForm = form
    }
}

// MARK: - Preview

struct CashFlowCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowCategoryListView(type: .expense)
            CashFlowCategoryListView(type: .expense)
        }
        .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
