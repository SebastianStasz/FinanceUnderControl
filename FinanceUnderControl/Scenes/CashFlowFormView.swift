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
    let type: CashFlowCategoryType

    @StateObject var viewModel = CashFlowFormVM()

    var body: some View {
        FormView {
            sectorBasicInfo
            sectorMoreInfo
        }
        .horizontalButtonsScroll(title: type.name,
                                 primaryButton: .init("Create", action: createCashFlow)
        )
        .onAppear(perform: onAppear)
    }

    private func onAppear() {
        viewModel.cashFlowModel.category = categories.first
        viewModel.cashFlowModel.type = type
    }

    private func createCashFlow() {
        guard let data = viewModel.cashFlowModel.cashFlowData else { return }
        CashFlowEntity.create(in: context, data: data)
    }

    init(for type: CashFlowCategoryType) {
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
