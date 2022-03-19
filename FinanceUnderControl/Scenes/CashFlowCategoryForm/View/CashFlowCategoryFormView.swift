//
//  CashFlowCategoryFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 04/03/2022.
//

import Combine
import SwiftUI
import FinanceCoreData

struct CashFlowCategoryFormView: BaseView {
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = CashFlowCategoryFormVM()
    let form: CashFlowFormType<CashFlowCategoryEntity>

    var elementsSpacing: CGFloat { .micro }

    var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: elementsSpacing), count: 6)
    }

    var baseBody: some View {
        FormView {
            categoryInfo
            colorSector
            iconSector
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
        viewModel.categoryModel = form.model
        viewModel.nameInput.value = form.model.name
    }
}

// MARK: - Preview

struct CashFlowCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryFormView(form: .new(for: .expense))
    }
}
