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
        List(cashFlowDates) { date in
            Section(date.stringMonthAndYear) {
                ForEach(cashFlowByDate[date]!, content: CashFlowPanelView.init)
            }
        }
        .listStyle(.insetGrouped)
        .background(Color.backgroundPrimary)
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

    private var cashFlowByDate: [Date: [CashFlowEntity]] {
        Dictionary(grouping: cashFlows, by: { $0.date.monthAndYearComponents })
    }

    private var cashFlowDates: [Date] {
        cashFlowByDate.keys.sorted { $0 > $1 }
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
