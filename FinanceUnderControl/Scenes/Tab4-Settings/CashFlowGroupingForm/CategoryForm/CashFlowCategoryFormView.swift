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
    @ObservedObject var viewModel: CashFlowCategoryFormVM

    var baseBody: some View {
        FormView {
            VStack(alignment: .center, spacing: .medium) {
                SquareView(icon: formModel.icon.rawValue, color: formModel.color.color, size: 95)
                LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput, style: .secondary)
            }
            .card()
            .padding(.horizontal, .large)

            Sector(.common_icon) {
                VStack(spacing: .small) {
                    ForEach(CashFlowCategoryIcon.groups) { group in
                        LazyVGrid(columns: grid, alignment: .center, spacing: elementsSpacing) {
                            ForEach(group.icons) { icon in
                                CircleView(color: .basicSecondary, icon: icon)
                                    .selection($viewModel.formModel.icon, element: icon)
                            }
                        }
                        Divider().displayIf(!group.isLast)
                    }
                }
                .card()
            }
        }
        .navigationTitle(title)
        .horizontalButtons(primaryButton: primaryButton)
    }

    private var primaryButton: HorizontalButtons.Configuration {
        .init(viewModel.formType.confirmButtonTitle, enabled: viewModel.formModel.isValid) {
            viewModel.binding.didTapConfirm.send()
        }
    }

    private var elementsSpacing: CGFloat { .micro }

    private var grid: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: elementsSpacing), count: 6)
    }

    private var title: String {
        if case .new = viewModel.formType {
            return .settings_create_category
        }
        return .settings_edit_category
    }

    private var formModel: CashFlowCategoryFormModel {
        viewModel.formModel
    }
}

// MARK: - Preview

//struct CashFlowCategoryFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CashFlowCategoryFormView(form: .new(for: .expense))
//        CashFlowCategoryFormView(form: .new(for: .expense)).darkScheme()
//    }
//}
