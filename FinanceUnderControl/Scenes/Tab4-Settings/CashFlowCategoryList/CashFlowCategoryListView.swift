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
    @FetchRequest private var categories: FetchedResults<CashFlowCategoryEntity>
    @State private var isAlertPresented = false
    @State private var isCreateCashFlowCategoryShown = false
    private let type: CashFlowCategoryType

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
        }
        .toolbar { toolbarContent }
        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
        .sheet(isPresented: $isCreateCashFlowCategoryShown) {
            CashFlowCategoryFormView(type: type)
        }
    }

    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            Toolbar.trailing(systemImage: SFSymbol.plus.name, action: presentCreateCashFlowCategoryPopup)
        }
    }

    // MARK: - Interactions

    private func presentCreateCashFlowCategoryPopup() {
        isCreateCashFlowCategoryShown = true
    }

    private func deleteCategory(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        if !categories[index].delete() {
            isAlertPresented = true
        }
    }
}


// MARK: - Preview

struct CashFlowCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryListView(type: .expense)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
