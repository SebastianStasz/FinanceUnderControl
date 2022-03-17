//
//  CashFlowFormView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 20/02/2022.
//

import SwiftUI
import FinanceCoreData

struct CashFlowFormView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest var currencies: FetchedResults<CurrencyEntity>
    @FetchRequest var categories: FetchedResults<CashFlowCategoryEntity>
    let type: CashFlowType

    @StateObject var viewModel = CashFlowFormVM()

    private var cashFlowData: CashFlowData? {
        viewModel.cashFlowModel.cashFlowData
    }

    var body: some View {
        FormView {
            sectorBasicInfo
            sectorMoreInfo
        }
        .horizontalButtonsScroll(title: type.name, primaryButton: .init(.button_create, enabled: cashFlowData.notNil, action: createCashFlow))
        .onAppear(perform: onAppear)
    }

    private func onAppear() {
        viewModel.cashFlowModel.category = categories.first
        viewModel.cashFlowModel.type = type
    }

    private func createCashFlow() {
        guard let data = cashFlowData else { return }
        CashFlowEntity.create(in: context, data: data)
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
        CashFlowFormView(for: .income)
    }
}
