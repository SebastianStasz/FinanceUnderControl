//
//  ExchangeRateListView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 30/11/2021.
//

import FinanceCoreData
import Shared
import SwiftUI
import SSUtils

struct ExchangeRateListView: View {

    @ObservedObject var viewModel: ExchangeRateListVM

    var body: some View {
        BaseList(title, elements: viewModel.exchangeRates) {
            BaseRowView(code: $0.code, info: $0.rateValue.description)
        }
        .searchable(text: $viewModel.searchText)
        .asSheet(title: title)
    }

    private var title: String {
        "Base: \(viewModel.baseCurrencyCode)"
    }
}


// MARK: - Preview

struct ExchangeRateListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.previewEmpty.context
        let currency = CurrencyEntity.sampleEUR(in: context)
        ExchangeRateListView(viewModel: .init(currencyEntity: currency))
            .embedInNavigationView(title: "Base: EUR", displayMode: .inline)
    }
}
