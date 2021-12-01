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
    let currency: CurrencyEntity

    var body: some View {
        BaseListView(items: currency.exchangeRatesArray) {
            CurrencyRowView(code: $0.code, info: $0.rateValue.description)
        }
        .toolbar { toolbarContent }
        .embedInNavigationView(title: "Base: \(currency.code)", displayMode: .inline)
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
        ExchangeRateListView(currency: currency)
            .embedInNavigationView(title: "Base: EUR", displayMode: .inline)
    }
}
