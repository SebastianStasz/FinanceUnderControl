//
//  CashFlowCategoryGroupFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import SwiftUI

struct CashFlowCategoryGroupFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel = CashFlowCategoryGroupFromVM()
    let form: CashFlowFormType<CashFlowCategoryGroupEntity>
    
    var body: some View {
        FormView {
            LabeledInputText("Name", input: $viewModel.categoryModel.nameInput)
        }
        .horizontalButtonsScroll(title: "Create", primaryButton: primaryButton)
        .onAppear { viewModel.categoryModel = form.model}
        .onReceive(viewModel.output.dismissView) { dismiss.callAsFunction() }
    }
    
    private var primaryButton: HorizontalButtons.Configuration {
        .init(form.confirmButtonTitle, enabled: viewModel.isFormValid, action: createCashFlowCategory)
    }

    private func createCashFlowCategory() {
        viewModel.input.didTapConfirm.send(form)
    }
}


// MARK: - Preview

struct CashFlowCategoryGroupFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryGroupFormView(form: .new(for: .expense))
    }
}
