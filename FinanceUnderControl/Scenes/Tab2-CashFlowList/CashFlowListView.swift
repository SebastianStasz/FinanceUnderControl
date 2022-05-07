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

struct CashFlowListView: BaseView {

    @ObservedObject var viewModel: CashFlowListVM
    @State private var isDeleteConfirmationShown = false

    private var isSearching: Bool {
        viewModel.cashFlowPredicate.notNil
    }

    private var emptyStateVD: EmptyStateVD {
        EmptyStateVD(title: "No cash flows yet",
                     description: "Cash flows will appear here after you create it",
                     isSearching: isSearching)
    }

    var baseBody: some View {
        Group {
            if viewModel.isLoading && viewModel.listSectors.isEmpty {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                    .overlay(LoadingIndicator(isLoading: true))
                    .navigationTitle(String.tab_cashFlow_title)
            } else {
                BaseList(.tab_cashFlow_title, emptyStateVD: emptyStateVD, sectors: viewModel.listSectors) {
                    CashFlowCardView($0)
                        .actions(edit: (), delete: reportDeleteCashFlow($0))
                }
            }
        }
        .confirmationDialog(String.settings_select_action, isPresented: $isDeleteConfirmationShown) {
            Button.delete { viewModel.binding.confirmCashFlowDeletion.send() }
            Button.cancel(action: {})
        }
//        .searchable(text: $viewModel.searchText)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: showFilterView) { filterIcon }
//                    .disabled(cashFlows.isEmpty && !isSearching)
//            }
//        }
//        .sheet(isPresented: $isFilterViewShown) {
//            CashFlowFilterView(cashFlowFilter: $viewModel.cashFlowFilter)
//        }
//        .onChange(of: viewModel.cashFlowPredicate) {
//            cashFlows.nsPredicate = $0
//        }
    }

    func reportDeleteCashFlow(_ cashFlow: CashFlow) {
        viewModel.binding.cashFlowToDelete.send(cashFlow)
        isDeleteConfirmationShown = true
    }

    @ViewBuilder
    private var filterIcon: some View {
        if viewModel.cashFlowPredicate.isNil {
            Image(systemName: SFSymbol.filter.name)
        } else {
            HStack(alignment: .top, spacing: .micro) {
                Circle()
                    .frame(width: .small, height: .small)
                    .padding(.top, 3)
                Image(systemName: SFSymbol.filter.name)
            }
        }
    }

    // MARK: - Interactions

//    private func showFilterView() {
//        isFilterViewShown = true
//    }
//
//    private func resetFilters() {
//        viewModel.cashFlowFilter.resetToDefaultValues()
//    }
//
//    private func showDeleteCashFlowConfirmation(for cashFlow: CashFlowEntity) {
//        cashFlowToDelete = cashFlow
//    }
//
//    private func deleteCashFlow() {
//        _ = cashFlowToDelete?.delete()
//        cashFlowToDelete = nil
//    }
}

// MARK: - Preview

struct CashFlowListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CashFlowListVM(coordinator: PreviewCoordinator())
        Group {
            CashFlowListView(viewModel: viewModel)
            CashFlowListView(viewModel: viewModel).darkScheme()
        }
        .embedInNavigationView()
        .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
