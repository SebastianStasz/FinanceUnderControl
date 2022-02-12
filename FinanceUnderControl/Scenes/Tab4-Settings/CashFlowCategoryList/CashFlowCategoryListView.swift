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
    @EnvironmentObject var appController: AppController
    @FetchRequest private var categories: FetchedResults<CashFlowCategoryEntity>
    @State private var isAlertPresented = false
    private let type: CashFlowCategoryType

    var body: some View {
        BaseList(type.name, elements: categories) {
            BaseRowView(text1: $0.name)
        } onDelete: {
            deleteCategory(at: $0)
        }
        .toolbar { toolbarContent }
        .infoAlert(isPresented: $isAlertPresented, message: .cannot_delete_cash_flow_category_message)
    }

    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            Toolbar.trailing(systemImage: SFSymbol.plus.name, action: presentCreateCashFlowCategoryPopup)
        }
    }

    // MARK: - Interactions

    private func presentCreateCashFlowCategoryPopup() {
        appController.presentPopup(.cashFlowCategory(for: type))
    }

    private func deleteCategory(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        if !categories[index].delete() {
            isAlertPresented = true
        }
    }

    // MARK: - Initializer

    init(type: CashFlowCategoryType) {
        self.type = type
        _categories = CashFlowCategoryEntity.fetchRequest(forType: type)
    }
}


// MARK: - Preview

struct CashFlowCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryListView(type: .expense)
    }
}
