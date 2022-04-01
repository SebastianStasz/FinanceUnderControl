//
//  CashFlowCategoryFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 04/03/2022.
//

import Combine
import Shared
import SwiftUI
import FinanceCoreData

struct CashFlowCategoryFormView: BaseView {
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = CashFlowGroupingFormVM<CashFlowCategoryEntity>()
    let form: CashFlowFormType<CashFlowCategoryEntity>

    var elementsSpacing: CGFloat { .micro }

    var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: elementsSpacing), count: 6)
    }

    var baseBody: some View {
        FormView {
            VStack(alignment: .center, spacing: .medium) {
                CircleView(color: categoryModel.color.color, icon: categoryModel.icon, size: 95)
                LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput, style: .secondary)
            }
            .card()
            .padding(.horizontal, .large)

            LazyVGrid(columns: grid, alignment: .center, spacing: elementsSpacing) {
                ForEach(CashFlowCategoryColor.allCases) { color in
                    CircleView(color: color.color)
                        .selection($viewModel.formModel.color, element: color)
                }
            }
            .embedInSection(.common_color, style: .card)

            LazyVGrid(columns: grid, alignment: .center, spacing: elementsSpacing) {
                ForEach(CashFlowCategoryIcon.allCases) { (icon: CashFlowCategoryIcon) in
                    CircleView(color: .basicSecondary, icon: icon)
                        .selection($viewModel.formModel.icon, element: icon)
                }
            }
            .embedInSection(.common_icon, style: .card)
        }
        .cashFlowGroupingForm(viewModel: viewModel, form: form)
    }

    private var categoryModel: CashFlowCategoryEntity.FormModel {
        viewModel.formModel
    }
}

// MARK: - Preview

struct CashFlowCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryFormView(form: .new(for: .expense))
    }
}
