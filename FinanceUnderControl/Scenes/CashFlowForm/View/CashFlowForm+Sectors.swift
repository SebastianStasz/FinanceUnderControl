//
//  CashFlowForm+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import Shared

extension CashFlowFormView {

    var sectorBasicInfo: some View {
        Sector("Basic") {
            LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
            LabeledTextField(.common_amount, viewModel: viewModel.valueInput)
        }
    }

    var sectorMoreInfo: some View {
        Sector("More") {
            LabeledPicker(.create_cash_flow_currency, elements: currencies, selection: $viewModel.cashFlowModel.currency)
            DatePicker("\(String.create_cash_flow_date):", selection: $viewModel.cashFlowModel.date, displayedComponents: [.date])
                .card()
            LabeledPicker(.common_category, elements: categories, selection: $viewModel.cashFlowModel.category)
        }
    }
}
