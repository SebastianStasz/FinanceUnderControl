//
//  CashFlowForm+Sectors.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI

extension CashFlowFormView {

    var sectorBasicInfo: some View {
        Sector("Basic") {
            LabeledInputText("Name", input: $viewModel.nameInput, prompt: "My expense")
            LabeledInputNumber("Value", input: $viewModel.valueInput, prompt: "100")
        }
    }

    var sectorMoreInfo: some View {
        Sector("More") {
            LabeledPicker("Currency:", elements: currencies, selection: $viewModel.cashFlowModel.currency)
            DatePicker("\(type.name) date:", selection: $viewModel.cashFlowModel.date, displayedComponents: [.date]).formField()
            LabeledPicker("Category:", elements: categories, selection: $viewModel.cashFlowModel.category)
        }
    }
}
