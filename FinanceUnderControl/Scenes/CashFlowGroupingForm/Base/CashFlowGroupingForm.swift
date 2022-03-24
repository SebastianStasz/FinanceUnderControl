//
//  CashFlowGroupingForm.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/03/2022.
//

import SwiftUI
import FinanceCoreData

private struct CashFlowGroupingForm<Entity: CashFlowFormSupport>: ViewModifier {

    @ObservedObject var viewModel: CashFlowGroupingFormVM<Entity>
    let form: CashFlowFormType<Entity>

    func body(content: Content) -> some View {
        content
            .horizontalButtonsScroll(title: form.title, primaryButton: primaryButton)
            .handleViewModelActions(viewModel)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(form.confirmButtonTitle, enabled: viewModel.isFormValid, action: createCashFlowCategory)
    }

    private func createCashFlowCategory() {
        viewModel.input.didTapConfirm.send(form)
    }

    func onAppear() {
        viewModel.onAppear(withModel: form.formModel)
    }
}

extension View {
    func cashFlowGroupingForm<Entity: CashFlowFormSupport>(
        viewModel: CashFlowGroupingFormVM<Entity>,
        form: CashFlowFormType<Entity>
    ) -> some View {
        modifier(CashFlowGroupingForm(viewModel: viewModel, form: form))
    }
}
