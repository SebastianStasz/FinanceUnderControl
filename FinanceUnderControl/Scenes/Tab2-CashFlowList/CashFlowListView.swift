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
    @FetchRequest(sortDescriptors: [CashFlowEntity.Sort.byDate(.reverse).nsSortDescriptor]
    ) private var cashFlows: FetchedResults<CashFlowEntity>

    @StateObject private var viewModel = CashFlowListVM()
    @State private var isFilterViewPresented = false

    var body: some View {
        BaseList(.tab_cashFlow_title, sectors: cashFlowSectors, rowView: CashFlowPanelView.init)
            .searchable(text: $viewModel.searchText)
            .toolbar { toolbarContent }
            .sheet(isPresented: $isFilterViewPresented) {
                CashFlowFilterView(cashFlowFilter: $viewModel.cashFlowFilter)
            }
            .onChange(of: viewModel.cashFlowPredicate) {
                cashFlows.nsPredicate = $0
            }
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.filter.name, action: presentFilterView)
    }

    private var cashFlowSectors: [ListSector<CashFlowEntity>] {
        Dictionary(grouping: cashFlows, by: { $0.date.monthAndYearComponents })
            .sorted { $0.key > $1.key }
            .map { ListSector($0.key.stringMonthAndYear, elements: $0.value) }
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
