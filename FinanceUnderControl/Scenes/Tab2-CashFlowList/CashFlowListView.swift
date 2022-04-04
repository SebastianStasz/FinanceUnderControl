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
    @SectionedFetchRequest(sectionIdentifier: \.monthAndYear, sortDescriptors: [CashFlowEntity.Sort.byDate(.reverse).nsSortDescriptor]
    ) private var cashFlows: SectionedFetchResults<Date, CashFlowEntity>

    @StateObject private var viewModel = CashFlowListVM()
    @State private var cashFlowToDelete: CashFlowEntity?
    @State private var isDeleteCashFlowShown = false
    @State private var isFilterViewShown = false
    @State private var cashFlowFormType: CashFlowFormType<CashFlowEntity>?

    var body: some View {
        BaseList(.tab_cashFlow_title, sectorIdMapper: dateToSectorTitle, sectors: cashFlows) { cashFlow in
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
        .overlay(ForEach(cashFlows) { _ in })
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.filter.name, action: showFilterView)
    }

    private func dateToSectorTitle(_ date: Date) -> String {
        date.string(format: .monthAndYear)
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
        cashFlowToDelete = nil
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
