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
    @State private var isDeleteGroupConfirmationShown = false
    let formType: CashFlowFormType<Entity>

    func body(content: Content) -> some View {
        content
            .asSheet(title: formType.title, askToDismiss: formType.formModel != viewModel.formModel, primaryButton: primaryButton, secondaryButton: secondaryButton)
            .handleViewModelActions(viewModel)
            .onAppear(perform: onAppear)
            .confirmationDialog("Delete cash flow group", isPresented: $isDeleteGroupConfirmationShown) {
                Button.delete(deleteCashFlowCategory)
            }
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(formType.confirmButtonTitle, enabled: viewModel.isFormValid, action: createCashFlowCategory)
    }

    private var secondaryButton: HorizontalButtons.Configuration? {
        guard case .edit = formType else { return nil }
        return .init("Delete") { isDeleteGroupConfirmationShown = true }
    }

    // MARK: - Interactions

    private func createCashFlowCategory() {
        viewModel.input.didTapConfirm.send(formType)
    }

    private func deleteCashFlowCategory() {
        viewModel.input.didTapDelete.send(formType)
    }

    func onAppear() {
        viewModel.onAppear(formType: formType)
    }
}

extension View {
    func cashFlowGroupingForm<Entity: CashFlowFormSupport>(
        viewModel: CashFlowGroupingFormVM<Entity>,
        form: CashFlowFormType<Entity>
    ) -> some View {
        modifier(CashFlowGroupingFormSheet(viewModel: viewModel, formType: form))
    }
}
