//
//  CashFlowCategoryGroupFormView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import FinanceCoreData
import SwiftUI

struct CashFlowCategoryGroupFormView: BaseView {
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = CashFlowCategoryGroupFromVM()
    let form: CashFlowFormType<CashFlowCategoryGroupEntity>

    var baseBody: some View {
        FormView {
            LabeledTextField("Name", viewModel: viewModel.nameInput)
        }
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
        viewModel.onAppear(withModel: form.model)
    }
}

// MARK: - Preview

struct CashFlowCategoryGroupFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryGroupFormView(form: .new(for: .expense))
    }
}
