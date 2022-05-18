//
//  CashFlowListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import Shared
import SwiftUI

struct CashFlowListView: BaseView {
    @ObservedObject var viewModel: CashFlowListVM
    @State private var isDeleteConfirmationShown = false

    var baseBody: some View {
        BaseList(isLoading: viewModel.isLoading, emptyStateVD: emptyStateVD, sectors: listSectors) {
            CashFlowCardView($0)
                .actions(edit: presentEditForm(for: $0), delete: reportDeleteCashFlow($0))
        }
        .searchable(text: $viewModel.searchText)
        .confirmationDialog(String.settings_select_action, isPresented: $isDeleteConfirmationShown) {
            Button.delete(action: confirmCashFlowDeletion)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: presentFilterView) { filterIcon }
                    .disabled(viewModel.listSectors.isEmpty)
            }
        }
    }

    private var isSearchingOrFiltering: Bool {
        viewModel.isSearching || viewModel.isFiltering
    }

    private var listSectors: [ListSector<CashFlow>] {
        isSearchingOrFiltering ? viewModel.filteredListSectors : viewModel.listSectors
    }

    private var emptyStateVD: EmptyStateVD {
        EmptyStateVD(title: "No cash flows yet",
                     description: "Cash flows will appear here after you create it",
                     isSearching: isSearchingOrFiltering)
    }

    private var filterIcon: some View {
        HStack(alignment: .top, spacing: .micro) {
            Circle()
                .frame(width: .small, height: .small)
                .padding(.top, 3)
                .displayIf(viewModel.isFiltering)
            Image(systemName: SFSymbol.filter.name)
        }
    }

    // MARK: - Interactions

    private func presentFilterView() {
        viewModel.binding.navigateTo.send(.filterView)
    }

    private func reportDeleteCashFlow(_ cashFlow: CashFlow) {
        viewModel.binding.cashFlowToDelete.send(cashFlow)
        isDeleteConfirmationShown = true
    }

    private func confirmCashFlowDeletion() {
        viewModel.binding.confirmCashFlowDeletion.send()
    }

    private func presentEditForm(for cashFlow: CashFlow) {
        viewModel.binding.navigateTo.send(.editForm(for: cashFlow))
    }
}

// MARK: - Preview

struct CashFlowListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CashFlowListVM(coordinator: PreviewCoordinator(), cashFlowFilterVM: .init())
        Group {
            CashFlowListView(viewModel: viewModel)
            CashFlowListView(viewModel: viewModel).darkScheme()
        }
        .embedInNavigationView()
    }
}
