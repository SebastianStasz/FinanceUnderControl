//
//  CurrencyListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 28/11/2021.
//

import CoreData
import FinanceCoreData
import SwiftUI

struct CurrencyListView: View {

    @ObservedObject var viewModel: CurrencyListVM
    let buttonType: BaseRowButtonType

    init(viewModel: CurrencyListVM, buttonType: BaseRowButtonType = .none) {
        self.viewModel = viewModel
        self.buttonType = buttonType
    }

    var body: some View {
        BaseListViewFetchRequest(items: viewModel.currencies) {
            CurrencyRowView(currency: $0)
                .baseRowView(buttonType: .forward, action: selectCurrency($0))
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer)
        .sheet(item: $viewModel.selectedCurrency) { ExchangeRateListView(currency: $0) }
    }

    // MARK: - Interactions

    private func selectCurrency(_ currenyEntity: CurrencyEntity) {
        viewModel.input.selectCurrency.send(currenyEntity)
    }
}


// MARK: - Preview

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView(viewModel: CurrencyListVM())
            .embedInNavigationView(title: "Currencies")
            .environment(\.managedObjectContext, PersistenceController.preview.context)
//            .environment(\.managedObjectContext, PersistenceController.previewEmpty.context)
    }
}
