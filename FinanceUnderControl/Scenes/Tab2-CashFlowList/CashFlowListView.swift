//
//  CashFlowListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import FinanceCoreData
import SwiftUI
import Shared
import SSUtils

struct CashFlowListView: View {
    @FetchRequest(sortDescriptors: [CashFlowEntity.Sort.byName(.forward).nsSortDescriptor])
    private var cashFlows: FetchedResults<CashFlowEntity>

    @State private var cashFlowSelection: CashFlowSelection = .all
    @State private var isFilterViewPresented = false

    var body: some View {
        ForEach(cashFlows) {
            BaseRowView(text1: $0.name)
        }
        .baseListStyle(title: "CashFlows", isEmpty: cashFlows.isEmpty)
        .toolbar { toolbarContent }
        .sheet(isPresented: $isFilterViewPresented) { CashFlowFilterView(cashFlowSelection: $cashFlowSelection) }
        .onChange(of: cashFlowSelection) { newValue in
            cashFlows.nsPredicate = newValue == .all ? nil : CashFlowEntity.Filter.byType(newValue.type!).nsPredicate
        }
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.filter.name, action: presentFilterView)
    }

    // MARK: - Interactions

    private func presentFilterView() {
        isFilterViewPresented = true
    }
}


// MARK: - Preview

struct CashFlowListView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowListView()
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
