//
//  CashFlowFilterView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 16/01/2022.
//

import Shared
import SwiftUI

struct CashFlowFilterView: BaseView {
    @ObservedObject var viewModel: CashFlowFilterVM

    var baseBody: some View {
        FormView {
            Sector(.cash_flow_filter_type) {
                SegmentedPicker(.cash_flow_filter_type, selection: filter.cashFlowSelection, elements: CashFlowSelection.allCases)
                LabeledPicker(.common_category, elements: viewModel.categories, selection: filter.cashFlowCategory)
                    .displayIf(filter.wrappedValue.cashFlowSelection != .all, withTransition: .scale)
            }
            Sector(.common_amount) {
                LabeledTextField(.cash_flow_filter_minimum_value, viewModel: viewModel.minValueInput)
                LabeledTextField(.cash_flow_filter_maximum_value, viewModel: viewModel.maxValueInput)
                LabeledPicker(.create_cash_flow_currency, elements: currenciesToSelect, selection: filter.currency)
            }
            Sector(.cash_flow_filter_other) {
                DateRangePicker(.cash_flow_filter_date_range, viewData: filter.datePickerViewData)
            }
        }
        .horizontalButtons(primaryButton: .init(.button_apply, action: viewModel.binding.applyFilters.send),
                           secondaryButton: .init(.button_reset, action: viewModel.binding.resetFilters.send))
    }

    private var filter: Binding<CashFlowFilter> {
        $viewModel.filter
    }

    private var currenciesToSelect: [Currency?] {
        var currencies: [Currency?] = Currency.allCases
        currencies.append(nil)
        return currencies
    }
}

// MARK: - Preview

struct CashFlowFilterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CashFlowFilterVM()
        CashFlowFilterView(viewModel: viewModel)
        CashFlowFilterView(viewModel: viewModel).darkScheme()
    }
}
