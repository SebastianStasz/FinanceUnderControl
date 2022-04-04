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
    @State private var isFilterViewShown = false
    @State private var cashFlowFormType: CashFlowFormType<CashFlowEntity>?

    var body: some View {
        BaseList(.tab_cashFlow_title, sectorIdMapper: dateToSectorTitle, sectors: cashFlows) { cashFlow in
            CashFlowPanelView(for: cashFlow)
                .actions(edit: editCashFlow(cashFlow), delete: showDeleteCashFlowConfirmation(for: cashFlow))
        }
        .searchable(text: $viewModel.searchText)
        .toolbar { toolbarContent }
        .confirmationDialog(.settings_select_action, item: $cashFlowToDelete) {
            Button.delete(deleteCashFlow)
            Button.cancel { cashFlowToDelete = nil }
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
    }

    private func deleteCashFlow() {
        _ = cashFlowToDelete?.delete()
        cashFlowToDelete = nil
    }
}

// MARK: - Preview

struct CashFlowListView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowListView()
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
