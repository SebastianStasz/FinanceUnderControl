//
//  CurrencyListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import CoreData
import FinanceCoreData
import SwiftUI
import Shared

struct CurrencyListView: PickerList {
    typealias Sort = CurrencyEntity.Sort
    typealias Filter = CurrencyEntity.Filter

    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [Sort.byCode(.forward).nsSortDescriptor]
    ) private var currencies: FetchedResults<CurrencyEntity>

    @State private var currenciesProvider = CurrenciesProvider()
    @State private var searchText = ""

    var selection: Binding<CurrencyEntity?>
    private let buttonType: BaseRowButtonType

    init(selection: Binding<CurrencyEntity?>, buttonType: BaseRowButtonType = .none) {
        self.selection = selection
        self.buttonType = buttonType
    }

    var body: some View {
        BaseList(.common_currencies, elements: currencies) { currency in
            Button(action: { selectCurrency(currency) }) {
                HStack(spacing: .medium) {
                    Text(currency.code, style: .currency)
                    Text(currency.name)
                    Spacer()
                    Checkmark(isChecked: selection.wrappedValue == currency)
                }
                .formField()
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
        .onChange(of: searchText, perform: updatePredicate)
    }

    // MARK: - Interactions

    private func selectCurrency(_ currenyEntity: CurrencyEntity) {
        selection.wrappedValue = currenyEntity
        dismiss()
    }

    private func updatePredicate(for text: String) {
        let text = ValidationHelper.search(text)
        currencies.nsPredicate = text .isEmpty ? nil : [Filter.codeContains(text), Filter.nameContains(text)].orNSPredicate
    }
}


// MARK: - Preview

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView(selection: .constant(nil))
            .embedInNavigationView(title: .common_currencies)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
//            .environment(\.managedObjectContext, PersistenceController.previewEmpty.context)
    }
}
