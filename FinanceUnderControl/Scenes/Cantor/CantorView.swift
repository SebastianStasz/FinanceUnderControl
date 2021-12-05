//
//  CantorView.swift
//  FinanceUnderControl
//
//  Created by Sebastian Staszczyk on 22/11/2021.
//

import FinanceCoreData
import SwiftUI

struct CantorView: View {

    @StateObject private var viewModel = CantorVM()
    @State private var exchangeRatesForCurrency: CurrencyEntity?

    var body: some View {
        Form {
            ListPicker(title: "From:", listView: CurrencyListView(selection: $viewModel.primaryCurrency))
            ListPicker(title: "To:", listView: CurrencyListView(selection: $viewModel.secondaryCurrency))

            Section {
                if let currency = viewModel.primaryCurrency {
                    Text("All exchange rates for \(currency.code)")
                        .baseRowView(buttonType: .sheet, isBlue: true, action: showExchangeRatesFor(currency))
                }
            }
        }
        .sheet(item: $exchangeRatesForCurrency) {
            ExchangeRateListView(viewModel: .init(currencyEntity: $0))
        }
    }

    // MARK: - Interactions

    private func showExchangeRatesFor(_ currency: CurrencyEntity) {
        exchangeRatesForCurrency = currency
    }
}


// MARK: - Preview

struct CantorView_Previews: PreviewProvider {
    static var previews: some View {
        CantorView()
            .embedInNavigationView()
    }
}
