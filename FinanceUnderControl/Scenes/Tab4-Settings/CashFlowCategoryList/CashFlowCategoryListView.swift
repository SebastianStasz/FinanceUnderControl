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
    @FetchRequest private var categoryGroups: FetchedResults<CashFlowCategoryGroupEntity>
    @FetchRequest private var ungroupedCategories: FetchedResults<CashFlowCategoryEntity>

    @State private var isAlertPresented = false
    @State private var chooseActionConfirmation = false
    @State private var categoryToDelete: CashFlowCategoryEntity?
    @State private var categoryForm: CashFlowFormType<CashFlowCategoryEntity>?
    @State private var categoryGroupForm: CashFlowFormType<CashFlowCategoryGroupEntity>?
    private let type: CashFlowType

    init(type: CashFlowType) {
        self.type = type
        _categoryGroups = CashFlowCategoryGroupEntity.fetchRequest(forType: type)
        _ungroupedCategories = CashFlowCategoryEntity.fetchRequest(forType: type, group: .ungrouped)
    }

    var body: some View {
        BaseList(type.namePlural, sectors: sectors) {
            CashFlowCategoryRow(for: $0, editCategory: showCategoryForm(.edit($0)))
                .actions(edit: showCategoryForm(.edit($0)), delete: showDeleteConfirmation($0))
                .environment(\.editMode, editMode)
        }
        .onDelete(perform: showDeleteConfirmation)
        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            Toolbar.trailing(systemImage: SFSymbol.plus.name) { showChooseActionConfirmation() }
        }
        .sheet(item: $categoryGroupForm) {
            CashFlowCategoryGroupFormView(form: $0)
        }
        .sheet(item: $categoryForm) {
            CashFlowCategoryFormView(form: $0)
        }
        .confirmationDialog("Delete category", item: $categoryToDelete) {
            Button.delete(deleteCategory)
            Button.cancel { categoryToDelete = nil }
        }
        .confirmationDialog(String.settings_select_action, isPresented: $chooseActionConfirmation) {
            Button(.settings_create_group, action: showCategoryGroupForm(.new(for: type)))
            Button(.settings_create_category, action: showCategoryForm(.new(for: type)))
        }
    }

    private var sectors: [ListSector<CashFlowCategoryEntity>] {
        var sectors = categoryGroups.map { group -> ListSector<CashFlowCategoryEntity> in
            let editAction = EditAction(title: .settings_edit_group) {
                showCategoryGroupForm(.edit(group))
            }
            return ListSector(group.name, elements: group.categories, editAction: editAction, visibleIfEmpty: true)
        }
        sectors.append(ListSector("Ungrouped", elements: ungroupedCategories.map { $0 }))
        return sectors
    }

    // MARK: - Interactions

    private func showChooseActionConfirmation() {
        chooseActionConfirmation = true
    }

    private func showCategoryGroupForm(_ form: CashFlowFormType<CashFlowCategoryGroupEntity>) {
        categoryGroupForm = form
    }

    private func showCategoryForm(_ form: CashFlowFormType<CashFlowCategoryEntity>) {
        categoryForm = form
    }

    private func showDeleteConfirmation(_ category: CashFlowCategoryEntity) {
        guard category.cashFlows.isEmpty else {
            isAlertPresented = true
            return
        }
        categoryToDelete = category
    }

    private func deleteCategory() {
        _ = categoryToDelete?.delete()
        categoryToDelete = nil
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
