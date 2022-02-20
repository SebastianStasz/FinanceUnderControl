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
        .horizontalButtonsScroll(primaryButton: .init("Apply", action: viewModel.applyFilters),
                                 secondaryButton: .init("Reset", action: viewModel.resetFilters)
        )
        .onAppear { viewModel.onAppear(cashFlowFilter: cashFlowFilter) }
        .onReceive(viewModel.output.cashFlowFilter) { cashFlowFilter = $0 }
        .onReceive(viewModel.output.dismissView) { dismiss.callAsFunction() }
        .onChange(of: viewModel.cashFlowCategoriesPredicate) { cashFlowCategories.nsPredicate = $0 }
    }
}


// MARK: - Preview

struct CashFlowFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowFilterView(cashFlowFilter: .constant(CashFlowFilter()))
    }
}
