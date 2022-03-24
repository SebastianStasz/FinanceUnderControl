//
//  CashFlowGroupingFormSheet.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/03/2022.
//

import SwiftUI
import FinanceCoreData

private struct CashFlowGroupingFormSheet<Entity: CashFlowFormSupport>: ViewModifier {

    @ObservedObject var viewModel: CashFlowGroupingFormVM<Entity>
    let form: CashFlowFormType<Entity>

    func body(content: Content) -> some View {
        content
            .asSheet(title: form.title, askToDismiss: form.build != viewModel.build, primaryButton: primaryButton)
            .handleViewModelActions(viewModel)
            .onAppear(perform: onAppear)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(form.confirmButtonTitle, enabled: viewModel.isFormValid, action: createCashFlowCategory)
    }

    private func createCashFlowCategory() {
        viewModel.input.didTapConfirm.send(form)
    }

    func onAppear() {
        viewModel.onAppear(withModel: form.build)
    }
}

extension View {
    func cashFlowGroupingForm<Entity: CashFlowFormSupport>(
        viewModel: CashFlowGroupingFormVM<Entity>,
        form: CashFlowFormType<Entity>
    ) -> some View {
        modifier(CashFlowGroupingFormSheet(viewModel: viewModel, form: form))
    }
}
