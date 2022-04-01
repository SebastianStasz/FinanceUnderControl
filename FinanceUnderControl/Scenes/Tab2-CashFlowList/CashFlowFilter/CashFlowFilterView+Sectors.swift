//
//  CashFlowFilterView+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import FinanceCoreData
import SwiftUI
import SSUtils
import Shared

extension CashFlowFilterView {

    var cashFlowTypeSector: some View {
        Sector(.cash_flow_filter_type) {
            SegmentedPicker(.cash_flow_filter_type, selection: filter.cashFlowSelection, elements: CashFlowSelection.allCases)
            LabeledPicker(.common_category, elements: cashFlowCategories, selection: filter.cashFlowCategory)
                .displayIf(filter.wrappedValue.cashFlowSelection != .all, withTransition: .scale)
        }
    }

    var amountSector: some View {
        Sector(.common_amount) {
            LabeledTextField(.cash_flow_filter_minimum_value, viewModel: viewModel.minValueInput)
            LabeledTextField(.cash_flow_filter_maximum_value, viewModel: viewModel.maxValueInput)
            LabeledPicker(.create_cash_flow_currency, elements: currenciesToSelect, selection: filter.currency)
        }
    }

    var otherSector: some View {
        Sector("Other") {
            DateRangePicker(.cash_flow_filter_date_range, viewData: filter.datePickerViewData)
        }
    }

    private var currenciesToSelect: [CurrencyEntity?] {
        var currencies: [CurrencyEntity?] = currencies.map { $0 }
        currencies.append(nil)
        return currencies
    }
}
