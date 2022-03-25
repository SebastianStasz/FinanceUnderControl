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
    let type: CashFlowType

    @StateObject var viewModel = CashFlowFormVM()

    private var cashFlowData: CashFlowEntity.Model? {
        viewModel.cashFlowModel.model
    }

    var baseBody: some View {
        FormView {
            sectorBasicInfo
            sectorMoreInfo
        }
        .asSheet(title: type.name, askToDismiss: viewModel.formChanged, primaryButton: primaruButton)
    }

    private var primaruButton: HorizontalButtons.Configuration {
        .init(.button_create, enabled: cashFlowData.notNil, action: createCashFlow)
    }

    func onAppear() {
        let model = CashFlowFormModel(category: categories.first, type: type)
        viewModel.initialCashFlowModel = model
        viewModel.cashFlowModel = model
    }

    private func createCashFlow() {
        guard let data = cashFlowData else { return }
        CashFlowEntity.create(in: context, model: data)
    }

    init(for type: CashFlowType) {
        self.type = type
        let currenciesSort = [CurrencyEntity.Sort.byCode(.forward).nsSortDescriptor]
        _currencies = FetchRequest<CurrencyEntity>(sortDescriptors: currenciesSort)
        _categories = CashFlowCategoryEntity.fetchRequest(forType: type)
    }
}

// MARK: - Preview

struct CashFlowFormView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowFormSheet(for: .income)
    }
}
