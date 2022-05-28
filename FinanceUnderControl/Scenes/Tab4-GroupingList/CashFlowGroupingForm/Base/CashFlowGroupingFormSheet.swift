//
//  CashFlowGroupingFormSheet.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 24/03/2022.
//

import SwiftUI
import FinanceCoreData

//private struct CashFlowGroupingFormSheet<Entity: CashFlowFormSupport>: ViewModifier {
//
//    @ObservedObject var viewModel: CashFlowGroupingFormVM<Entity>
//    let formType: CashFlowFormType<Entity>
//
//    func body(content: Content) -> some View {
//        content
//            .onAppear(perform: onAppear)
//            .asSheet(title: formType.title, askToDismiss: formType.formModel != viewModel.formModel, primaryButton: primaryButton)
//    }
//
//    private var primaryButton: HorizontalButtons.Configuration {
//        .init(formType.confirmButtonTitle, enabled: viewModel.isFormValid, action: createCashFlowCategory)
//    }
//
//    // MARK: - Interactions
//
//    private func createCashFlowCategory() {
//        viewModel.input.didTapConfirm.send(formType)
//    }
//
//    func onAppear() {
//        viewModel.onAppear(formType: formType)
//    }
//}
//
//extension View {
//    func cashFlowGroupingForm<Entity: CashFlowFormSupport>(
//        viewModel: CashFlowGroupingFormVM<Entity>,
//        form: CashFlowFormType<Entity>
//    ) -> some View {
//        modifier(CashFlowGroupingFormSheet(viewModel: viewModel, formType: form))
//    }
//}
