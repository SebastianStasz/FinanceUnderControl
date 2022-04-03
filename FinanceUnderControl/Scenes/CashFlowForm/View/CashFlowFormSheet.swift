//
//  CashFlowFormSheet.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import FinanceCoreData

struct CashFlowFormSheet: BaseView {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest var currencies: FetchedResults<CurrencyEntity>
    @FetchRequest var categories: FetchedResults<CashFlowCategoryEntity>
    let formType: CashFlowFormType<CashFlowEntity>

    @StateObject var viewModel = CashFlowFormVM()

    private var cashFlowData: CashFlowEntity.Model? {
        viewModel.formModel.model
    }

    var baseBody: some View {
        FormView {
            sectorBasicInfo
            sectorMoreInfo
        }
        .asSheet(title: formType.title, askToDismiss: viewModel.formChanged, primaryButton: primaruButton)
        .handleViewModelActions(viewModel)
    }

    private var primaruButton: HorizontalButtons.Configuration {
        .init(formType.confirmButtonTitle, enabled: cashFlowData.notNil, action: didTapConfirm)
    }

    func onAppear() {
        viewModel.onAppear(formType: formType)
    }

    private func didTapConfirm() {
        viewModel.didTapConfirm.send(formType)
    }

    init(for formType: CashFlowFormType<CashFlowEntity>) {
        self.formType = formType
        let currenciesSort = [CurrencyEntity.Sort.byCode(.forward).nsSortDescriptor]
        _currencies = FetchRequest<CurrencyEntity>(sortDescriptors: currenciesSort)
        _categories = CashFlowCategoryEntity.fetchRequest(forType: formType.formModel.type ?? .income)
    }
}

// MARK: - Preview

struct CashFlowFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowFormSheet(for: .new(for: .income))
    }
}
