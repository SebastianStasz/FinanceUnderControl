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
    @State private var isFilterViewShown = false
    @State private var cashFlowToDelete: CashFlowEntity?
    @State private var cashFlowFormType: CashFlowFormType<CashFlowEntity>?

    private var isSearching: Bool {
        viewModel.cashFlowPredicate.notNil
    }

    private var emptyStateVD: EmptyStateVD {
        EmptyStateVD(title: "No cash flows yet",
                     description: "Cash flows will appear here after you create it",
                     isSearching: isSearching)
    }

    var body: some View {
        BaseList(.tab_cashFlow_title, emptyStateVD: emptyStateVD, sectorIdMapper: { $0.string(format: .monthAndYear) }, sectors: cashFlows) {
            CashFlowCardView($0)
                .actions(edit: editCashFlow($0), delete: showDeleteCashFlowConfirmation(for: $0))
        }
        .searchable(text: $viewModel.searchText)
        .toolbar {
            Toolbar.trailing(systemImage: SFSymbol.filter.name, disabled: cashFlows.isEmpty && !isSearching, action: showFilterView)
        }
        .confirmationDialog(.settings_select_action, item: $cashFlowToDelete) {
            Button.delete(action: deleteCashFlow)
            Button.cancel { cashFlowToDelete = nil }
        }
        .sheet(item: $cashFlowFormType) {
            CashFlowFormView(for: $0)
        }
        .sheet(isPresented: $isFilterViewShown) {
            CashFlowFilterView(cashFlowFilter: $viewModel.cashFlowFilter)
        }
        .onChange(of: viewModel.cashFlowPredicate) {
            cashFlows.nsPredicate = $0
        }
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
        try? AppVM.shared.context.save()
        AppVM.shared.events.cashFlowsChanged.send()
    }
}

// MARK: - Preview

struct CashFlowListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowListView()
            CashFlowListView().darkScheme()
        }
        .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
