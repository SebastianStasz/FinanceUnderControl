//
//  CashFlowFilterView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import FinanceCoreData
import SwiftUI

struct CashFlowFilterView: BaseView {
    @Environment(\.dismiss) private var dismiss

    @FetchRequest(sortDescriptors: [CashFlowCategoryEntity.Sort.byName(.forward).nsSortDescriptor])
    var cashFlowCategories: FetchedResults<CashFlowCategoryEntity>

    @StateObject var viewModel = CashFlowFilterVM()
    @Binding var cashFlowFilter: CashFlowFilter

    var filter: Binding<CashFlowFilter> {
        $viewModel.cashFlowFilter
    }

    var baseBody: some View {
        FormView {
            cashFlowTypeSector
            amountSector
            otherSector
        }
        .asSheet(title: .cash_flow_filter_title,
                 primaryButton: .init(.button_apply, action: viewModel.applyFilters),
                 secondaryButton: .init(.button_reset, action: viewModel.resetFilters)
        )
        .onReceive(viewModel.action.applyFilters) { cashFlowFilter = $0 }
        .onChange(of: viewModel.cashFlowCategoriesPredicate) { cashFlowCategories.nsPredicate = $0 }
        .handleViewModelActions(viewModel)
    }

    func onAppear() {
        viewModel.onAppear(cashFlowFilter: cashFlowFilter)
    }
}

// MARK: - Preview

struct CashFlowFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowFilterView(cashFlowFilter: .constant(CashFlowFilter()))
    }
}
