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
    @State private var cashFlowToDelete: CashFlowEntity?
    @State private var isDeleteCashFlowShown = false
    @State private var isFilterViewShown = false
    @State private var cashFlowFormType: CashFlowFormType<CashFlowEntity>?

    var body: some View {
        BaseList(.tab_cashFlow_title, sectors: cashFlowSectors) { cashFlow in
            CashFlowPanelView(for: cashFlow)
                .contextMenu {
                    Button.edit(editCashFlow(cashFlow))
                    Button.delete(showDeleteCashFlowConfirmation(for: cashFlow))
                }
        }
            .onDelete(perform: showDeleteCashFlowConfirmation)
            .searchable(text: $viewModel.searchText)
            .toolbar { toolbarContent }
            .confirmationDialog(String.settings_select_action, isPresented: $isDeleteCashFlowShown) {
                Button("Delete", role: .destructive, action: deleteCashFlow)
                Button("Cancel", role: .cancel) { cashFlowToDelete = nil }
            }
            .sheet(item: $cashFlowFormType) {
                CashFlowFormSheet(for: $0)
            }
            .sheet(isPresented: $isFilterViewShown) {
                CashFlowFilterView(cashFlowFilter: $viewModel.cashFlowFilter)
            }
            .onChange(of: viewModel.cashFlowPredicate) {
                cashFlows.nsPredicate = $0
            }
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.filter.name, action: showFilterView)
    }

    private var cashFlowSectors: [ListSector<CashFlowEntity>] {
        Dictionary(grouping: cashFlows, by: { $0.date.monthAndYearComponents })
            .sorted { $0.key > $1.key }
            .map { ListSector($0.key.stringMonthAndYear, elements: $0.value) }
    }

    // MARK: - Interactions

    private func showFilterView() {
        isFilterViewShown = true
    }

    private func editCashFlow(_ cashFlow: CashFlowEntity) {
        cashFlowFormType = .edit(cashFlow)
    }

    private func showDeleteCashFlowConfirmation(for cashFlow: CashFlowEntity) {
        cashFlowToDelete = cashFlow
        isDeleteCashFlowShown = true
    }

    private func deleteCashFlow() {
        _ = cashFlowToDelete?.delete()
    }
}

// MARK: - Preview

struct CashFlowListView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowListView()
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
