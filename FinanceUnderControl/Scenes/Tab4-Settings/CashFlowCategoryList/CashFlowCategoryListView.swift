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
    @FetchRequest private var categories: FetchedResults<CashFlowCategoryEntity>
    @State private var isAlertPresented = false
    @State private var isCreateCashFlowCategoryShown = false
    private let type: CashFlowCategoryType
    @State private var categoryForm: CashFlowCategoryForm?

    init(type: CashFlowCategoryType) {
        self.type = type
        _categories = CashFlowCategoryEntity.fetchRequest(forType: type)
    }

    var body: some View {
        BaseList(type.namePlural, elements: categories, onDelete: deleteCategory) { category in
            HStack(spacing: .medium) {
                CircleView(color: category.color.color, icon: category.icon, size: 28)
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
        .sheet(item: $categoryForm) { CashFlowCategoryFormView(form: $0) }
    }

    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            Toolbar.trailing(systemImage: SFSymbol.plus.name) { presentCategoryForm(.new(for: type))}
        }
    }

    // MARK: - Interactions

    private func presentCategoryForm(_ form: CashFlowCategoryForm) {
        categoryForm = form
        editMode?.animation().wrappedValue = .inactive
    }

    private func deleteCategory(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        deleteCategory(categories[index])
    }

    private func deleteCategory(_ category: CashFlowCategoryEntity) {
        let wasDeleted = category.delete()
        if !wasDeleted { isAlertPresented = true }
    }
}


// MARK: - Preview

struct CashFlowCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryListView(type: .expense)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
