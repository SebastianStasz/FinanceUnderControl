//
//  CashFlowFilterView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import FinanceCoreData
import SwiftUI
import SSValidation

struct CashFlowFilterView: View {
    @Environment(\.dismiss) private var dismiss

    @FetchRequest(sortDescriptors: [CashFlowCategoryEntity.Sort.byName(.forward).nsSortDescriptor]
    ) private var cashFlowCategories: FetchedResults<CashFlowCategoryEntity>

    @StateObject private var viewModel = CashFlowFilterVM()
    @Binding var cashFlowFilter: CashFlowFilter

    var body: some View {
        VStack(spacing: .medium) {

            VStack(alignment: .leading, spacing: .small) {
                Text("Cash flow type")
                SegmentedPicker("Cash flow type", selection: $viewModel.cashFlowFilter.cashFlowSelection, elements: CashFlowSelection.allCases)
            }

            LabeledPicker("Category", elements: cashFlowCategories, selection: $viewModel.cashFlowFilter.cashFlowCategory)
                .displayIf(viewModel.cashFlowFilter.cashFlowSelection != .all)

            DateRangePicker("Date", viewData: $viewModel.cashFlowFilter.datePickerViewData)

            LabeledTextField<NumberInputVM>(title: "Minimum value", input: $viewModel.cashFlowFilter.minimumValueInput, prompt: "None")
                .formField()

            LabeledTextField<NumberInputVM>(title: "Maximum value", input: $viewModel.cashFlowFilter.maximumValueInput, prompt: "None")
                .formField()

            Spacer()

            BaseButton("Apply", action: viewModel.applyFilters)
            BaseButton("Reset", action: viewModel.resetFilters)
        }
        .padding(.top, .big)
        .padding(.horizontal, .medium)
        .background(Color.backgroundPrimary)
        .asSheet(title: "Filter")

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
