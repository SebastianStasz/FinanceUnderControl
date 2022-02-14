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
        VStack(spacing: .big) {
            Sector("Cash flow type") {
                SegmentedPicker("Cash flow type", selection: $viewModel.cashFlowFilter.cashFlowSelection, elements: CashFlowSelection.allCases)

                LabeledPicker("Category", elements: cashFlowCategories, selection: $viewModel.cashFlowFilter.cashFlowCategory)
                    .displayIf(viewModel.cashFlowFilter.cashFlowSelection != .all)
            }

            Sector("Amount") {
                LabeledTextField<NumberInputVM>(title: "Minimum value", input: $viewModel.cashFlowFilter.minimumValueInput, prompt: "None")
                    .formField()

                LabeledTextField<NumberInputVM>(title: "Maximum value", input: $viewModel.cashFlowFilter.maximumValueInput, prompt: "None")
                    .formField()
            }

            Sector("Other") {
                DateRangePicker("Date", viewData: $viewModel.cashFlowFilter.datePickerViewData)
            }
        }
        .stackedButtons(primaryButton: .init("Apply", action: viewModel.applyFilters),
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
