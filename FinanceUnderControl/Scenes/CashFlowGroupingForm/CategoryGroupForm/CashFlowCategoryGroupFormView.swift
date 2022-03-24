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

    @StateObject var viewModel = CashFlowGroupingFormVM<CashFlowCategoryGroupEntity>()
    let form: CashFlowFormType<CashFlowCategoryGroupEntity>

    var baseBody: some View {
        FormView {
            LabeledTextField("Name", viewModel: viewModel.nameInput)
        }
        .cashFlowGroupingForm(viewModel: viewModel, form: form)
    }
}

// MARK: - Preview

struct CashFlowCategoryGroupFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCategoryGroupFormView(form: .new(for: .expense))
    }
}
