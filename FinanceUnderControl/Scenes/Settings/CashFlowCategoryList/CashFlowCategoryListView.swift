//
//  CashFlowCategoryListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 25/12/2021.
//

import SwiftUI
import FinanceCoreData

struct CashFlowCategoryListView: View {

    @State private var isAlertPresented = false
    @FetchRequest private var categories: FetchedResults<CashFlowCategoryEntity>

    private let type: CashFlowCategoryType

    init(type: CashFlowCategoryType) {
        self.type = type
        let sort = [CashFlowCategoryEntity.Sort.byName(.forward).nsSortDescriptor]
        let filter = CashFlowCategoryEntity.Filter.typeIs(type).nsPredicate
        _categories = FetchRequest<CashFlowCategoryEntity>(sortDescriptors: sort, predicate: filter)
    }

    var body: some View {
        ForEach(categories) {
            BaseRowView(text1: $0.name)
        }
        .onDelete(perform: deleteCategory)
        .baseListStyle(title: type.name, isEmpty: categories.isEmpty)
        .toolbar { EditButton() }
        .infoAlert(isPresented: $isAlertPresented, message: "You can not delete this category, because it is in use.")
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
    }
}
