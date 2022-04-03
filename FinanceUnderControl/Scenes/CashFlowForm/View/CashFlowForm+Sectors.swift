//
//  CashFlowForm+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import Shared

extension CashFlowFormSheet {

    var sectorBasicInfo: some View {
        Sector(.create_cash_flow_basic_label) {
            LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
            LabeledTextField(.common_amount, viewModel: viewModel.valueInput)
        }
    }

    var sectorMoreInfo: some View {
        Sector(.create_cash_flow_more_label) {
            LabeledPicker(.create_cash_flow_currency, elements: currencies, selection: $viewModel.formModel.currency)
            LabeledDatePicker(.create_cash_flow_date, selection: $viewModel.formModel.date)
            LabeledPicker(.common_category, elements: categories, selection: $viewModel.formModel.category)
        }
    }
}
