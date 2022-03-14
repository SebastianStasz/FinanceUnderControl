//
//  CashFlowFilterView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import FinanceCoreData
import SwiftUI

struct CashFlowFilterView: View {
    @Environment(\.dismiss) private var dismiss

    @FetchRequest(sortDescriptors: [CashFlowCategoryEntity.Sort.byName(.forward).nsSortDescriptor])
    var cashFlowCategories: FetchedResults<CashFlowCategoryEntity>

    @StateObject private var viewModel = CashFlowFilterVM()
    @Binding var cashFlowFilter: CashFlowFilter

    var filter: Binding<CashFlowFilter> {
        $viewModel.cashFlowFilter
    }

    var body: some View {
        FormView {
            cashFlowTypeSector
            amountSector
            otherSector
        }
        .horizontalButtonsScroll(title: .cash_flow_filter_title,
                                 primaryButton: .init(.button_apply, action: viewModel.applyFilters),
                                 secondaryButton: .init(.button_reset, action: viewModel.resetFilters)
        )
        .onAppear { viewModel.onAppear(cashFlowFilter: cashFlowFilter) }
        .onReceive(viewModel.action.applyFilters) { cashFlowFilter = $0 }
        .handleViewModelActions(viewModel)
        .onChange(of: viewModel.cashFlowCategoriesPredicate) { cashFlowCategories.nsPredicate = $0 }
    }
}


// MARK: - Preview

struct CashFlowFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowFilterView(cashFlowFilter: .constant(CashFlowFilter()))
    }
}
