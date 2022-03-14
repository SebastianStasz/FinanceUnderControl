//
//  CashFlowCategoryFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 04/03/2022.
//

import Combine
import SwiftUI
import FinanceCoreData

struct CashFlowCategoryFormView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = CashFlowCategoryFormVM()
    let form: CashFlowFormType<CashFlowCategoryEntity>

    var elementsSpacing: CGFloat { .micro }

    var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: elementsSpacing), count: 6)
    }

    var body: some View {
        FormView {
            categoryInfo
            colorSector
            iconSector
        }
        .horizontalButtonsScroll(title: "Create", primaryButton: primaryButton)
        .onAppear { viewModel.categoryModel = form.model}
        .handleViewModelActions(viewModel)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(form.confirmButtonTitle, enabled: viewModel.isFormValid, action: createCashFlowCategory)
    }

    private func createCashFlowCategory() {
        viewModel.input.didTapConfirm.send(form)
    }
}


// MARK: - Preview

struct CashFlowCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryFormView(form: .new(for: .expense))
    }
}
