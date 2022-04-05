//
//  CashFlowFormSheet.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import FinanceCoreData
import Shared
import SwiftUI

struct CashFlowFormSheet: BaseView {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest private var currencies: FetchedResults<CurrencyEntity>
    @FetchRequest private var categories: FetchedResults<CashFlowCategoryEntity>
    @StateObject private var viewModel = CashFlowFormVM()
    private let formType: CashFlowFormType<CashFlowEntity>

    init(for formType: CashFlowFormType<CashFlowEntity>) {
        self.formType = formType
        let currenciesSort = [CurrencyEntity.Sort.byCode(.forward).nsSortDescriptor]
        _currencies = FetchRequest<CurrencyEntity>(sortDescriptors: currenciesSort)
        _categories = CashFlowCategoryEntity.fetchRequest(forType: formType.formModel.type ?? .income)
    }

    var baseBody: some View {
        FormView {
            Sector(.create_cash_flow_basic_label) {
                LabeledTextField(.create_cash_flow_name, viewModel: viewModel.nameInput)
                LabeledTextField(.common_amount, viewModel: viewModel.valueInput)
            }

            Sector(.create_cash_flow_more_label) {
                LabeledPicker(.create_cash_flow_currency, elements: currencies, selection: $viewModel.formModel.currency)
                LabeledDatePicker(.create_cash_flow_date, selection: $viewModel.formModel.date)
                LabeledPicker(.common_category, elements: categories, selection: $viewModel.formModel.category)
            }
        }
        .asSheet(title: formType.title, askToDismiss: viewModel.formChanged, primaryButton: primaruButton)
        .handleViewModelActions(viewModel)
    }

    private var primaruButton: HorizontalButtons.Configuration {
        .init(formType.confirmButtonTitle, enabled: viewModel.formModel.model.notNil, action: didTapConfirm)
    }

    func onAppear() {
        viewModel.onAppear(formType: formType)
    }

    private func didTapConfirm() {
        viewModel.didTapConfirm.send(formType)
    }
}

// MARK: - Preview

struct CashFlowFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowFormSheet(for: .new(for: .income))
    }
}
