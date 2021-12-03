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

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExchangeRateListVM

    var body: some View {
        BaseListView(items: viewModel.exchangeRates) {
            CurrencyRowView(code: $0.code, info: $0.rateValue.description)
        }
        .toolbar { toolbarContent }
        .searchable(text: $viewModel.searchText)
        .embedInNavigationView(title: "Base: \(viewModel.baseCurrencyCode)", displayMode: .inline)
    }

    private var toolbarContent: some ToolbarContent {
        Toolbar.trailing(systemImage: SFSymbol.close.name, action: dismiss.callAsFunction)
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
