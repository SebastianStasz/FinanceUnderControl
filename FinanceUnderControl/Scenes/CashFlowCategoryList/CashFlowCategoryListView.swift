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

    @State private var isAlertPresented = false
    @State private var isPopupPresented = false
    @FetchRequest private var categories: FetchedResults<CashFlowCategoryEntity>
    private let type: CashFlowCategoryType

    var body: some View {
        ForEach(categories) {
            BaseRowView(text1: $0.name)
        }
        .onDelete(perform: deleteCategory)
        .baseListStyle(title: type.name, isEmpty: categories.isEmpty)
        .toolbar { toolbarContent }
        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
        .popup(isPresented: isPopupPresented) { CashFlowCategoryCreatorView(for: type, isPresented: $isPopupPresented) }
    }

    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            Toolbar.trailing(systemImage: SFSymbol.plus.name, action: presentCreateCashFlowCategoryPopup)
        }
    }

    // MARK: - Interactions

    private func presentCreateCashFlowCategoryPopup() {
        isPopupPresented = true
    }

    private func deleteCategory(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        if !categories[index].delete() {
            isAlertPresented = true
        }
    }

    init(type: CashFlowCategoryType) {
        self.type = type
        let sort = [CashFlowCategoryEntity.Sort.byName(.forward).nsSortDescriptor]
        let filter = CashFlowCategoryEntity.Filter.typeIs(type).nsPredicate
        _categories = FetchRequest<CashFlowCategoryEntity>(sortDescriptors: sort, predicate: filter)
    }
}


// MARK: - Preview

struct CashFlowCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryListView(type: .expense)
    }
}
