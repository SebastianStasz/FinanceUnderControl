//
//  ManageCategoriesView.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 01/06/2022.
//

import Shared
import SwiftUI

struct ManageCategoriesView: View {

    @ObservedObject var viewModel: CashFlowCategoryGroupFormVM

    var body: some View {
        FormView {
            Sector(.common_include) {
                ForEach(viewModel.formModel.includedCategories) {
                    CashFlowCategoryGroupItem(for: $0, isOn: true, action: uncheckCategory($0))
                }
            }
            .displayIf(viewModel.formModel.includedCategories.isNotEmpty)
            
            Sector(.create_cash_flow_more_label) {
                ForEach(viewModel.formModel.otherCategories) {
                    CashFlowCategoryGroupItem(for: $0, isOn: false, action: checkCategory($0))
                }
            }
            .displayIf(viewModel.formModel.otherCategories.isNotEmpty)
        }
    }

    // MARK: - Interactions

    private func uncheckCategory(_ category: CashFlowCategory) {
        viewModel.formModel.uncheckCategory(category)
    }

    private func checkCategory(_ category: CashFlowCategory) {
        viewModel.formModel.checkCategory(category)
    }
}

// MARK: - Preview

struct ManageCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CashFlowCategoryGroupFormVM(for: .new(.expense), coordinator: nil)
        ManageCategoriesView(viewModel: viewModel)
        ManageCategoriesView(viewModel: viewModel).darkScheme()
    }
}
