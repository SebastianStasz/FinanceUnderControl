//
//  CashFlowPopup.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 11/01/2022.
//

import SwiftUI
import SSValidation
import FinanceCoreData

struct CashFlowPopup: View {
    @Environment(\.managedObjectContext) private var context

    @StateObject private var viewModel = CashFlowPopupVM()
    @FetchRequest private var currencies: FetchedResults<CurrencyEntity>
    @FetchRequest private var categories: FetchedResults<CashFlowCategoryEntity>
    let type: CashFlowCategoryType

    var body: some View {
        VStack {
            BaseInputText(title: "Name", input: $viewModel.nameInput)
            BaseInputNumber(title: "Value", input: $viewModel.valueInput)
            LabeledPicker("Currency:", elements: currencies, selection: $viewModel.cashFlowModel.currency)
            DatePicker("\(type.name) date:", selection: $viewModel.cashFlowModel.date, displayedComponents: [.date])
                .padding(.small)
                .background(Color.backgroundSecondary)
                .cornerRadius(.base)
            LabeledPicker("Category:", elements: categories, selection: $viewModel.cashFlowModel.category)
        }
        .asPopup(title: type.name, isActionDisabled: viewModel.cashFlowModel.cashFlowData.isNil, action: createCashFlow)
        .onAppear {
            viewModel.cashFlowModel.category = categories.first
            viewModel.cashFlowModel.type = type
        }
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

struct CashFlowPopup_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowPopup(for: .income)
    }
}
