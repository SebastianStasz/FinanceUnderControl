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
        BaseList(title, elements: viewModel.exchangeRates) { exchageRate in
            HStack(spacing: .medium) {
                Text(exchageRate.code, style: .currency)
                Text(exchageRate.rateValueRounded)
            }
            .formField()
        }
        .searchable(text: $viewModel.searchText)
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
