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

    private var sectors: [ListSector<CashFlowCategoryEntity>] {
        var sectors = categoryGroups.map { ListSector($0.name, elements: $0.categories, visibleIfEmpty: true) }
        sectors.append(ListSector("Ungrouped", elements: ungroupedCategories.map { $0 }))
        return sectors
    }

    var body: some View {
        ForEach(categories) { _ in } // Its needed to properly update categories fetched from groups after editing.

        BaseList(type.namePlural, sectors: sectors, onDelete: deleteCategory) { category in
            HStack(spacing: .medium) {
                CircleView(color: category.color.color, icon: category.icon, size: 20)
                Text(category.name)
            }
            .card()
            .contextMenu {
                Button("Edit", action: presentCategoryForm(.edit(category)))
                Button("Delete", role: .destructive) { deleteCategory(category) }
            }
        }
        .toolbar { toolbarContent }
        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
        .sheet(item: $categoryGroupForm) { CashFlowCategoryGroupFormView(form: $0) }
        .sheet(item: $categoryForm) { CashFlowCategoryFormView(form: $0) }
        .confirmationDialog("Select an action", isPresented: $isConfirmationDialogPresented) {
            Button("Create group", action: presentCategoryGroupForm(.new(for: type)))
            Button("Create category", action: presentCategoryForm(.new(for: type)))
        }
    }

    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            Toolbar.trailing(systemImage: SFSymbol.plus.name) { presentConfirmationDialog() }
        }
    }

    // MARK: - Interactions

   private func presentConfirmationDialog() {
       isConfirmationDialogPresented = true
   }

    private func presentCategoryForm(_ form: CashFlowFormType<CashFlowCategoryEntity>) {
        categoryForm = form
        editMode?.animation().wrappedValue = .inactive
    }

    private func deleteCategory(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        deleteCategory(ungroupedCategories[index])
    }

    private func deleteCategory(_ category: CashFlowCategoryEntity) {
        let wasDeleted = category.delete()
        if !wasDeleted { isAlertPresented = true }
    }

    private func presentCategoryGroupForm(_ form: CashFlowFormType<CashFlowCategoryGroupEntity>) {
        categoryGroupForm = form
        editMode?.animation().wrappedValue = .inactive
    }
}

// MARK: - Preview

struct CashFlowCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowCategoryListView(type: .expense)
                .environment(\.managedObjectContext, PersistenceController.preview.context)
            CashFlowCategoryListView(type: .expense)
                .environment(\.managedObjectContext, PersistenceController.preview.context)
        }
    }
}
