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
    @FocusState private var isFocused: Bool

    var baseBody: some View {
        FormView {
            VStack(alignment: .center, spacing: .medium) {
                SquareView(icon: formModel.icon.rawValue, color: formModel.color.color, size: 95)
                BaseTextField(.create_cash_flow_name, viewModel: viewModel.nameInput, style: .secondary)
                    .focused($isFocused)
            }
            .card()
            .padding(.horizontal, .large)

            Sector(.common_icon) {
                VStack(spacing: .small) {
                    ForEach(CashFlowCategoryIcon.groups) { group in
                        LazyVGrid(columns: grid, alignment: .center, spacing: elementsSpacing) {
                            ForEach(group.icons) { icon in
                                CircleView(color: .basicPrimary, image: icon.rawValue)
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
        .closeButton { viewModel.binding.navigateTo.send(.dismiss) }
        .onTapGesture { isFocused = false }
        .onAppearFocus($isFocused)
        .handleViewModelActions(viewModel)
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
